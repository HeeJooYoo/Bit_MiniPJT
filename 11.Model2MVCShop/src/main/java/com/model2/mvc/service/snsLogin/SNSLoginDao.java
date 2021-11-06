package com.model2.mvc.service.snsLogin;

import com.model2.mvc.service.domain.User;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
public interface SNSLoginDao {
	
	// INSERT
	public void addSNSLogin(User user) throws Exception ;

	// SELECT ONE
	public User getSNSLogin(String email) throws Exception ;
}