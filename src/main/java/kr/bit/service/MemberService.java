package kr.bit.service;

import kr.bit.entity.Member;

public interface MemberService {
	
	public Member registerCheck(String memID);
	public int register(Member m);
	public Member memLogin(Member m);

}
