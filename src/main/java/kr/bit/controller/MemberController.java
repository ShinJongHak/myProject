package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@RequestMapping("/memJoin.do")
	public String memberJoinForm(){
		
		return "member/memJoinForm";
		
	}
    

	
}