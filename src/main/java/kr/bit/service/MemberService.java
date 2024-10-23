package kr.bit.service;

import kr.bit.entity.AuthVO;
import kr.bit.entity.Member;

public interface MemberService {
	
	public Member registerCheck(String memID);
	public int emailCheck(Member m);
	public int register(Member m);
	public Member memLogin(String username);
	public Member getMember(String memID);
	public int memUpdate(Member m);
	public void memProfileUpdate(Member m);
	public void authInsert(AuthVO authVO);
	public void authDelete(String memID);

}
