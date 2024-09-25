package kr.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.bit.service.MemberService;
import kr.bit.entity.AuthVO;
import kr.bit.entity.Member;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	public MemberService memberService;
	
	@Autowired 
	PasswordEncoder pwEncoder;
	
	// 회원가입 페이지
	@RequestMapping("/memJoinForm.do")
	public String memberJoinForm(){
		
		return "member/memJoinForm";
		
	}
	// 중복처리
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		Member m=memberService.registerCheck(memID);
		if(m!=null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 입력불가
		}
		return 1; //사용가능한 아이디
	}
	
	// 회원가입 처리
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m, String memPassword1, String memPassword2,
			                  RedirectAttributes rttr, HttpSession session) {
		if(m.getMemID()==null || m.getMemID().equals("") ||
		   memPassword1==null || memPassword1.equals("") ||
		   memPassword2==null || memPassword2.equals("") ||
		   m.getMemName()==null || m.getMemName().equals("") ||	
		   m.getMemAge()==0 ||  m.getAuthList().size() == 0 ||
		   m.getMemGender()==null || m.getMemGender().equals("") ||
		   m.getMemEmail()==null || m.getMemEmail().equals("")) {
		   // 누락메세지를 가지고 가기? =>객체바인딩(Model, HttpServletRequest, HttpSession)
		   rttr.addFlashAttribute("msgType", "실패 메세지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
		   return "redirect:/memJoin.do";  // ${msgType} , ${msg}
		}
		if(!memPassword1.equals(memPassword2)) {
		   rttr.addFlashAttribute("msgType", "실패 메세지");
		   rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
		   return "redirect:/memJoin.do";  // ${msgType} , ${msg}
		}		
		m.setMemProfile(""); // 사진이미지는 없다는 의미
		
		// 비밀번호를 암호화 하기(API)
	    String encyptPw=pwEncoder.encode(m.getMemPassword());
	    m.setMemPassword(encyptPw);
		
			try {
				int result=memberService.register(m);
				
				if(result==1) { // 회원가입 성공 메세지
					   List<AuthVO> list=m.getAuthList();
					   System.out.println(list);
					   for(AuthVO authVO : list) {
						   if(authVO.getAuth()!=null) {
							   AuthVO saveVO=new AuthVO();
							   saveVO.setMemID(m.getMemID()); //회원아이디
							   saveVO.setAuth(authVO.getAuth()); //회원의권한
							   System.out.println(saveVO);
							   memberService.authInsert(saveVO);
						   }
				}
					   
				rttr.addFlashAttribute("msgType", "성공 메세지");
			    rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
				Member mvo=memberService.getMember(m.getMemID());
				session.setAttribute("mvo", mvo);
				return "redirect:/";
			 }
			}
			catch(DuplicateKeyException e){
				 rttr.addFlashAttribute("msgType", "실패 메세지");
				 rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
				 return "redirect:/member/memJoin.do";
			}
			return "redirect:/memLoginForm.do";
	}
    
	// 로그인 화면으로 이동(스프링시큐리티)
    @RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
    	
	   return "member/memLoginForm"; 
		
    }
    
    // 로그인 기능 구현
 	@RequestMapping("/memLogin.do")
 	public String memLogin(Member m, RedirectAttributes rttr, HttpSession session) {
 		if(m.getMemID()==null || m.getMemID().equals("") ||
 		   m.getMemPassword()==null || m.getMemPassword().equals("")) {
 		   rttr.addFlashAttribute("msgType", "실패 메세지");
 		   rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요.");
 		   return "redirect:/member/memLoginForm.do";			
 		}
 		Member mvo=memberService.memLogin(m);
 		if(mvo!=null) { // 로그인에 성공
 		   rttr.addFlashAttribute("msgType", "성공 메세지");
 		   rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
 		   session.setAttribute("mvo", mvo); // ${!empty mvo}
 		   return "redirect:/";	 // 메인		
 		}else { // 로그인에 실패
 			System.out.println("실패");
 		   rttr.addFlashAttribute("msgType", "실패 메세지");
 		   rttr.addFlashAttribute("msg", "다시 로그인 해주세요.");
 		   return "redirect:/member/memLoginForm.do";
 		}		
 	}
    
    // 로그아웃 처리
 	@RequestMapping("/memLogout.do")
 	public String memLogout(HttpSession session) {
 		session.invalidate();
 		return "redirect:/";
 	}
 	
 	// 사진등록 페이지
 	@RequestMapping("/memImageForm.do")
 	public String memImageForm() {
    	
 	   return "member/memImageForm"; 
 		
     }
 	
 	// 회원정보수정화면
 	@RequestMapping("/memUpdateForm.do")
 	public String memUpdateForm() {
 		return "member/memUpdateForm";
 	}
 	// 회원정보수정
 	@RequestMapping("/memUpdate.do")
 	public String memUpdate(Member m, RedirectAttributes rttr,
 			String memPassword1, String memPassword2, HttpSession session) {
 		if(m.getMemID()==null || m.getMemID().equals("") ||
 		   memPassword1==null || memPassword1.equals("") ||
 		   memPassword2==null || memPassword2.equals("") ||
 		   m.getMemName()==null || m.getMemName().equals("") ||	
 		   m.getMemAge()==0 ||
 		   m.getMemGender()==null || m.getMemGender().equals("") ||
 		   m.getMemEmail()==null || m.getMemEmail().equals("")) {
 		   // 누락메세지를 가지고 가기? =>객체바인딩(Model, HttpServletRequest, HttpSession)
 		   rttr.addFlashAttribute("msgType", "실패 메세지");
 		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
 		   return "redirect:/member/memUpdateForm.do";  // ${msgType} , ${msg}
 		}
 		if(!memPassword1.equals(memPassword2)) {
 		   rttr.addFlashAttribute("msgType", "실패 메세지");
 		   rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
 		   return "redirect:/member/memUpdateForm.do";  // ${msgType} , ${msg}
 		}		
 		// 회원을 수정저장하기
 		int result=memberService.memUpdate(m);
 		if(result==1) { // 수정성공 메세지
 		   rttr.addFlashAttribute("msgType", "성공 메세지");
 		   rttr.addFlashAttribute("msg", "회원정보 수정에 성공했습니다.");
 		   // 회원수정이 성공하면=>로그인처리하기
 		   Member mvo = memberService.getMember(m.getMemID());
 		   session.setAttribute("mvo", mvo); // ${!empty mvo}
 		   return "redirect:/";
 		}else {
 		   rttr.addFlashAttribute("msgType", "실패 메세지");
 		   rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
 		   return "redirect:/member/memUpdateForm.do";
 		}
 	}
 	
 	
	// 회원사진 이미지 업로드(upload, DB저장)
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request,HttpSession session, RedirectAttributes rttr) throws IOException {
		// 파일업로드 API(cos.jar, 3가지)
		MultipartRequest multi=null;
		int fileMaxSize=40*1024*1024; // 10MB		
		String savePath=request.getRealPath("resources/upload"); // 1.png
		try {                                                                        // 1_1.png
			// 이미지 업로드
			multi=new MultipartRequest(request, savePath, fileMaxSize, "UTF-8",new DefaultFileRenamePolicy());
		
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");			
			return "redirect:/member/memImageForm.do";
		}
		// 데이터베이스 테이블에 회원이미지를 업데이트
		String memID=multi.getParameter("memID");
		String newProfile="";
		File file=multi.getFile("memProfile");
		if(file !=null) { // 업로드가 된상태(.png, .jpg, .gif)
			// 이미파일 여부를 체크->이미지 파일이 아니면 삭제(1.png)
			String ext=file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext=ext.toUpperCase(); // PNG, GIF, JPG
			if(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")){
				// 새로 업로드된이미지(new->1.PNG), 현재DB에 있는 이미지(old->4.PNG)
				String oldProfile=memberService.getMember(memID).getMemProfile();
				File oldFile=new File(savePath+"/"+oldProfile);
				if(oldFile.exists()) {
					oldFile.delete();
				}
				newProfile=file.getName();
			}else { // 이미지 파일이 아니면
				if(file.exists()) {
					file.delete(); //삭제
				}
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.");			
				return "redirect:/member/memImageForm.do";
			}
		}
		// 새로운 이미지를 테이블에 업데이트
		Member mvo=new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		memberService.memProfileUpdate(mvo); // 이미지 업데이트 성공
		Member m=memberService.getMember(memID);
		// 세션을 새롭게 생성한다.
		session.setAttribute("mvo", m);
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다.");	
		return "redirect:/";
	}	
     
	
}