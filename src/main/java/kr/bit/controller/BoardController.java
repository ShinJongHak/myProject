package kr.bit.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;

@Controller
@RequestMapping("board/*")
public class BoardController{	
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/list.do")
	public String getList(Criteria cri, Model model) {
		System.out.println(cri);
		List<Board> list=boardService.getList(cri);
		System.out.println(list);
		// 객체바인딩
		model.addAttribute("list", list); // Model
		// 페이징 처리에 필요한 부분
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));
		model.addAttribute("pageMaker", pageMaker);		
		return "board/list"; // View
 	}
	
	@RequestMapping("/registerForm.do")
	public String registerForm() {
		return "board/register";
	}
	
	@RequestMapping("/register.do")
	public String register(Board vo) {
		boardService.insert(vo);
		return "redirect:/board/list.do";
	}
	
}