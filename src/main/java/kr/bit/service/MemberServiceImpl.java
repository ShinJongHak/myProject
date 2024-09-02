package kr.bit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Member;
import kr.bit.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberMapper memberMapper;

	@Override
	public Member registerCheck(String memID) {
		Member m = memberMapper.registerCheck(memID);
		return m;
	}

	@Override
	public int register(Member m) {
		int result = memberMapper.register(m);
		return result;
	}

	@Override
	public Member memLogin(Member m) {
		Member mvo = memberMapper.memLogin(m);
		return mvo;
	}

	@Override
	public Member getMember(String memID) {
		Member m = memberMapper.getMember(memID);
		return m;
	}

	@Override
	public void memProfileUpdate(Member mvo) {
		memberMapper.memProfileUpdate(mvo);
	}

	@Override
	public int memUpdate(Member mvo) {
		
		return memberMapper.memUpdate(mvo);
		
	}

}
