package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.mapper.BoardMapper;


@Service
@Primary
public class BoardServiceIpml implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<Board> getList(Criteria cri) {
		List<Board> list = boardMapper.getList(cri);
		return list;
	}
	
	@Override
	public void insert(Board vo) {
		boardMapper.insert(vo);
		
	}

	@Override
	public int totalCount(Criteria cri) {
		int total = boardMapper.totalCount(cri);
		return total;
	}

	

}
