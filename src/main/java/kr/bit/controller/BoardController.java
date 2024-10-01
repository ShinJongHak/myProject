package kr.bit.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		List<Board> list=boardService.getList(cri);
		model.addAttribute("list", list); 
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));
		model.addAttribute("pageMaker", pageMaker);	
		System.out.println("검색11");
		return "board/list"; 
 	}
	
	
	@RequestMapping("/registerForm.do")
	public String registerForm() {
		return "board/register";
	}
	
	@RequestMapping("/register.do")
	public String register(Board vo) {
		boardService.register(vo);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("/get.do")
	public String getForm(@RequestParam("idx") int idx, Criteria cri, Model model) {
		Board vo = boardService.get(idx);
		boardService.boardCount(idx); //조회수
		model.addAttribute("vo", vo);
		model.addAttribute("cri", cri);
		return "board/get";
		
	}
	
	@RequestMapping("/IndexGet.do")
	public String IndexGetForm(@RequestParam("idx") int idx,  Model model) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		return "board/get";
		
	}
	
	@RequestMapping("/modifyForm.do")
	public String modifyForm(@RequestParam("idx") int idx, Criteria cri, Model model) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("cri", cri);
		return "board/modify";
		
	}
	
	@RequestMapping("/modify.do")
	public String modify(Board board) {
		boardService.modify(board);
		
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("/remove.do")
	public String remove(@RequestParam("idx") int idx, Criteria cri, RedirectAttributes rttr) {
		boardService.remove(idx);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("pageNum", cri.getPerPageNum());
		
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("/replyForm.do")
	public String replyForm(@RequestParam("idx") int idx, Model model, Criteria cri) {
		Board vo = boardService.get(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("cri", cri);
		
		return "board/reply";
		
	}
	
	@RequestMapping("/reply.do")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) {
		boardService.replyProcess(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());		
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list.do";
		
	}
}