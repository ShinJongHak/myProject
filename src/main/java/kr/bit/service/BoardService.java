package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;

public interface BoardService {
	public List<Board> getList(Criteria cri);
	public void insert(Board vo);
	
	public int totalCount(Criteria cri);

}
