package kr.bit.service;

import java.util.List;

import kr.bit.entity.AuthVO;
import kr.bit.entity.Board;
import kr.bit.entity.Criteria;

public interface BoardService {
	public List<Board> getList(Criteria cri);
	public void register(Board vo);
	public Board get(int idx);
	public void modify(Board board);
	public void remove(int idx);
	public void boardCount (int idx);
	public void replyProcess(Board vo);
	public int totalCount(Criteria cri);

}
