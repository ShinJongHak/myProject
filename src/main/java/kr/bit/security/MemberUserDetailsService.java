package kr.bit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.bit.entity.Member;
import kr.bit.entity.MemberUser;
import kr.bit.mapper.MemberMapper;
import kr.bit.service.MemberService;

public class MemberUserDetailsService implements UserDetailsService{
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Member mvo=memberMapper.memLogin(username);
		//-->UserDetails -> implements--->User -> extends--->MemberUser
		if(mvo != null) {
			return new MemberUser(mvo); // new MemberUser(mvo); // Member, AuthVO
		}else {
	   	   throw new UsernameNotFoundException("user with username" + username + "does not exist."); 	
		}
	}

}
