package com.model2.mvc.service.snsLogin;

import com.model2.mvc.service.domain.User;


//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface SNSLoginService {
	
	// 회원가입
	public void addSNSLogin(User user) throws Exception ;
	
	// 내정보확인 / 로그인
	public User getSNSLogin(String email) throws Exception ;
}