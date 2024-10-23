package kr.bit.mapper;


import org.apache.ibatis.annotations.Mapper;

import kr.bit.entity.AuthVO;
import kr.bit.entity.Member;

@Mapper 
public interface MemberMapper {	 
	public Member registerCheck(String memID);
	public int emailCheck(Member m);
	public int register(Member m); 
	public Member memLogin(String username); 
	public int memUpdate(Member mvo); 
	public Member getMember(String memID);
	public void memProfileUpdate(Member mvo);
	public void authInsert(AuthVO authVO);
	public void authDelete(String memID);
	
}