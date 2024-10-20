package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import kr.bit.entity.AuthVO;
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
	public void register(Board vo) {
		boardMapper.insert(vo);
		
	}

	@Override
	public int totalCount(Criteria cri) {
		int total = boardMapper.totalCount(cri);
		return total;
	}

	@Override
	public Board get(int idx) {
		Board vo = boardMapper.read(idx);
		return vo;
	}

	@Override
	public void modify(Board board) {
		boardMapper.update(board);
		
	}

	@Override
	public void remove(int idx) {
		boardMapper.delete(idx);
		
	}
	
	@Override
	public void boardCount(int idx) {
		boardMapper.boardCount(idx);
	}

	@Override
	public void replyProcess(Board vo) {
		Board parent=boardMapper.read(vo.getIdx());
		vo.setBoardGroup(parent.getBoardGroup());
		vo.setBoardSequence(parent.getBoardSequence()+1);
		vo.setBoardLevel(parent.getBoardLevel()+1);
		
		boardMapper.replySeqUpdate(parent);
		boardMapper.replyInsert(vo);
		
	}


	

	

}
