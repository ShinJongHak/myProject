package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.service.BoardService;

@Controller
public class MainController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/")
	public String index(Criteria cri, Model model) {
		List<Board> list=boardService.getList(cri);
		model.addAttribute("list", list); 
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount(cri));
		model.addAttribute("pageMaker", pageMaker);
		return "main/index"; 
	}
}