package com.model2.mvc.service.snsLogin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.snsLogin.SNSLoginDao;
import com.model2.mvc.service.snsLogin.SNSLoginService;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.UserDao;;


//==> 회원관리 서비스 구현
@Service("snsLoginServiceImpl")
public class SNSLoginServiceImpl implements SNSLoginService{
	
	///Field
	@Autowired
	@Qualifier("snsLoginDaoImpl")
	private SNSLoginDao snsLoginDao;
	
	///Constructor
	public SNSLoginServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addSNSLogin(User user) throws Exception {
		// TODO Auto-generated method stub
		snsLoginDao.addSNSLogin(user);
	}

	@Override
	public User getSNSLogin(String email) throws Exception {
		// TODO Auto-generated method stub
		return snsLoginDao.getSNSLogin(email);
	}
}