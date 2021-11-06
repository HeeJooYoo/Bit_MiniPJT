package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.snsLogin.SNSLoginService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
	
	///Field
	@Autowired
	@Qualifier("snsLoginServiceImpl")
	private SNSLoginService snsLoginService;
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login( @RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if(dbUser != null) {
			if( user.getPassword().equals(dbUser.getPassword())){
				System.out.println("login session 저장");
				session.setAttribute("user", dbUser);
			} else {
				dbUser = null;
			}
		} 
		
		return dbUser;
	}
	
	@RequestMapping( value="json/checkDuplication", method=RequestMethod.POST )
	public Map<String, Object> checkDuplication(@RequestBody User user) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(user.getUserId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", new Boolean(result));
		map.put("userId", user.getUserId());

		return map;
	}
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public User addUser(@RequestBody User user) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		System.out.println("userId :: " + user.getUserId());
		
		User resultUser = userService.getUser(user.getUserId());
		
		return resultUser;
	}
	
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId) throws Exception{
		
		System.out.println("/user/updateUser : GET");
		
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public Map updateUser( @RequestBody User user, HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
//		String sessionId=((User)session.getAttribute("user")).getUserId();
//		if(sessionId.equals(user.getUserId())){
//			session.setAttribute("user", user);
//		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", userService.getUser(user.getUserId()));
		System.out.println("updateUser session :: " + map.get("user"));
		
		return map;
	}
	
	@RequestMapping(value="json/listUser")
	public Map listUser(@RequestBody Search search) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = userService.getUserList(search);
		System.out.println("updateUser session :: " + map.get("user"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}

	@RequestMapping(value = "/json/googleCheck", method = RequestMethod.POST)
	public User googleAuth(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("/user/json/googleCheck : POST");
		
		User user = snsLoginService.getSNSLogin(request.getParameter("email"));
		
		if (user == null) {
			user = new User();
		} else {
			session.setAttribute("user", user);
		}
		
		return user;
	}
}
	