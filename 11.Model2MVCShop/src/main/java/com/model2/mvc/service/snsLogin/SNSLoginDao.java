package com.model2.mvc.service.snsLogin;

import com.model2.mvc.service.domain.User;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface SNSLoginDao {
	
	// INSERT
	public void addSNSLogin(User user) throws Exception ;

	// SELECT ONE
	public User getSNSLogin(String email) throws Exception ;
}