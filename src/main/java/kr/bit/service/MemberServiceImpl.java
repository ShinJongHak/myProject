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

}
