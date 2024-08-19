package kr.bit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.service.MemberService;
import kr.bit.entity.Member;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	public MemberService memberService;
	
	
	@RequestMapping("/memJoin.do")
	public String memberJoinForm(){
		
		return "member/memJoinForm";
		
	}
	
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
		   m.getMemAge()==0 || 
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
		m.setMemProfile(""); // 사진이미는 없다는 의미 ""
		// 회원을 테이블에 저장하기
		// 추가 : 비밀번호를 암호화 하기(API)
	    /*String encyptPw=pwEncoder.encode(m.getMemPassword());
	    m.setMemPassword(encyptPw);*/
	    // register() 수정
		
			try {
				int result=memberService.register(m);
				if(result==1) { // 회원가입 성공 메세지
					   rttr.addFlashAttribute("msgType", "성공 메세지");
					   rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
					   session.setAttribute("mvo", m);
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
 		System.out.println(m);
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
	
}