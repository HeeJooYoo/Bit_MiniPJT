package com.model2.mvc.service.snsLogin;

import com.model2.mvc.service.domain.User;


//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition  
public interface SNSLoginService {
	
	// ȸ������
	public void addSNSLogin(User user) throws Exception ;
	
	// ������Ȯ�� / �α���
	public User getSNSLogin(String email) throws Exception ;
}