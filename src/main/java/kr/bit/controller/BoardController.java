package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("board/*")
public class BoardController{	
	
	@RequestMapping("/list.do")
	public String main() {
		return "board/list"; 
	}
	
	@RequestMapping("/register.do")
	public String register() {
		return "board/register";
		
	}
	
}