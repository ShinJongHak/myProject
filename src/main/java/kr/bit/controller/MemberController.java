package kr.bit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		System.out.println("중복");
		Member m=memberService.registerCheck(memID);
		if(m!=null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 입력불가
		}
		return 1; //사용가능한 아이디
	}
    

	
}