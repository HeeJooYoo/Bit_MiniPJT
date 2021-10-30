package client.app;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;



public class RestHttpClientApp {
	
	// main Method
	public static void main(String[] args) throws Exception{
		
		////////////////////////////////////////////////////////////////////////////////////////////
		// 주석을 하나씩 처리해가며 실습
		////////////////////////////////////////////////////////////////////////////////////////////
		
//		System.out.println("\n====================================\n");
//		// 1.1 Http Get 방식 Request : JsonSimple lib 사용
//		RestHttpClientApp.getUserTest_JsonSimple();
		
//		System.out.println("\n====================================\n");
//		// 1.2 Http Get 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.getUserTest_Codehaus();
		
//		System.out.println("\n====================================\n");
//		// 2.1 Http Post 방식 Request : JsonSimple lib 사용
//		RestHttpClientApp.LoginTest_JsonSimple();
		
//		System.out.println("\n====================================\n");
//		// 1.2 Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.LoginTest_Codehaus();		
	
//		==================================================================	

//		addUserTest_JsonSimple();
//		addUserTest_Codehaus();
		
//		updateUserGetTest(); //JsonSimple
//		updateUserPostTest(); //Codehaus
		
//		listUserPostTest(); //Codehaus
//		listUserGetTest();
		
//		updateProductGetTest(); //Codehaus
//		updateProductPostTest(); //Codehaus	
		
//		addProductPostTest();
//		getProductGetTest();
		
//		listProductPostTest();
//		listProductGetTest();
		
//		addPurchseGetTest();
//		addPurchsePostTest();
		
		getPurchseGetTest();
		updatePurchseGetTest();
	}
	
	
//================================================================//
	//1.1 Http Protocol GET Request : JsonSimple 3rd party lib 사용
	public static void getUserTest_JsonSimple() throws Exception{
		HttpGETConnection("/user/json/getUser/admin");
	}
	
	
	//1.2 Http Protocol GET Request : JsonSimple + codehaus 3rd party lib 사용
	public static void getUserTest_Codehaus() throws Exception{
		
		JSONObject jsonobj = HttpGETConnection("/user/json/getUser/admin");
	
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
	}
//================================================================//	
	
//================================================================//
	//2.1 Http Protocol POST Request : FromData 전달 / JsonSimple 3rd party lib 사용
	public static void LoginTest_JsonSimple() throws Exception{
		
		JSONObject json = new JSONObject();
		json.put("userId", "admin");
		json.put("password", "1234");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("json", json);
		
		HttpPOSTConnection("/user/json/login", map);	
	}
	
	
	//2.2 Http Protocol POST 방식 Request : FromData전달 
	//==> JsonSimple + codehaus 3rd party lib 사용
	public static void LoginTest_Codehaus() throws Exception{
		
//		//[ 방법 1 : String 사용]
//		String data =  "{\"userId\":\"admin\",\"password\":\"1234\"}";
//		HttpEntity httpEntity01 = new StringEntity(data,"utf-8");
	
//		//[ 방법 2 : JSONObject 사용]
//		JSONObject json = new JSONObject();
//		json.put("userId", "admin");
//		json.put("password", "1234");
//		HttpEntity httpEntity01 = new StringEntity(json.toString(),"utf-8");
		
		//[ 방법 3 : codehaus 사용]
		User user =  new User();
		user.setUserId("user12");
		user.setPassword("1212");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", user);
		
		JSONObject jsonobj = HttpPOSTConnection("/user/json/login", map);

		ObjectMapper objectMapper = new ObjectMapper();
		User user01 = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user01);
	}	
	
	
	//========================================================================
	//211019-211027 추가부분
	
	public static void addUserTest_JsonSimple() throws Exception {
		
		JSONObject json = new JSONObject();
		json.put("userId", "hjy");
		json.put("password", "1234");
		json.put("userName", "SCOTT");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("json", json);

		HttpPOSTConnection("/user/json/addUser", map);
	}
	
	public static void addUserTest_Codehaus() throws Exception {
		
		User user =  new User();
		user.setUserId("hjy");
		user.setPassword("1234");
		user.setUserName("SCOTT");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", user);
		
		JSONObject jsonobj = HttpPOSTConnection("/user/json/addUser", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		User user01 = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user01);
	}
	
	public static void updateUserGetTest() throws Exception {		
		HttpGETConnection("/user/json/updateUser/user12");
	}
	
	public static void updateUserPostTest() throws Exception {
		
		JSONObject json = new JSONObject();
		json.put("userId", "user12");
		json.put("userName", "SCOTT");
		json.put("phone", "000-0000-0000");
		json.put("addr", "종각비트캠프");
		json.put("email", "hhh@jjj.com");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("json", json);
		JSONObject jsonobj = HttpPOSTConnection("/user/json/updateUser", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.get("user").toString(), User.class);
		System.out.println(user);
	}
	
	public static void listUserPostTest() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		//search.setSearchCondition("0");
		//search.setSearchKeyword("user12");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", search);
		
		JSONObject jsonobj = HttpPOSTConnection("/user/json/listUser", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		ArrayList<User> list = objectMapper.readValue(jsonobj.get("list").toString(), ArrayList.class);
		System.out.println(list);
	}
	
	public static void listUserGetTest() throws Exception {
//		Search search = new Search();
//		search.setCurrentPage(1);
//		search.setPageSize(3);
//		//search.setSearchCondition("1");
//		//search.setSearchKeyword("user12");
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("domain", search);
		
		HttpGETConnection("/user/json/listUser");
	}
	
	
	//======================== Product =====================================
	
	public static void addProductPostTest() throws Exception {
		Product product = new Product();
		product.setFileName("aaaaa.jpg");
		product.setManuDate("20211025");
		product.setPrice(10000);
		product.setProdDetail("json test이다요");
		product.setProdName("jsonTest");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", product);
		
		JSONObject jsonObject = HttpPOSTConnection("/product/json/addProduct", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		Product resultProduct = objectMapper.readValue(jsonObject.toString(), Product.class);
		System.out.println(resultProduct);
	}
	
	public static void getProductGetTest() throws Exception {
		JSONObject jsonobj = HttpGETConnection("/product/json/getProduct/manage/10001");
		
		ObjectMapper objectMapper = new ObjectMapper();
		Product product = objectMapper.readValue(jsonobj.toString(), Product.class);
		System.out.println(product);
	}
	
	public static void updateProductGetTest() throws Exception {
		
		JSONObject jsonobj = HttpGETConnection("/product/json/updateProduct/10001");
	
		ObjectMapper objectMapper = new ObjectMapper();
		Product product = objectMapper.readValue(jsonobj.toString(), Product.class);
		System.out.println(product);
		
	}
	
	public static void updateProductPostTest() throws Exception {
		Product product = new Product();
		product.setProdNo(10008);
		product.setProdName("change");
		product.setPrice(0);
		product.setProdDetail("변경했슴돠");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", product);
		
		JSONObject jsonobj = HttpPOSTConnection("/product/json/updateProduct", map);
	
		ObjectMapper objectMapper = new ObjectMapper();
		Product product01 = objectMapper.readValue(jsonobj.toString(), Product.class);
		System.out.println(product01);
	}
	
	public static void listProductPostTest() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		//search.setSearchCondition("1");
		//search.setSearchKeyword("자");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", search);
		
		JSONObject jsonobj = HttpPOSTConnection("/product/json/listProduct", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		List list = (List) jsonobj.get("list");
		System.out.println(list);
		
		for(int i=0;i<list.size();i++) {
			Product product = objectMapper.readValue(list.get(i).toString(), Product.class);
			System.out.println(product);
		}
//		List list = objectMapper.readValue(object.toString(), ArrayList.class);
//		System.out.println(list);
	}
	
	public static void listProductGetTest() throws Exception {

		HttpGETConnection("/product/json/listProduct");
	}
	
	
	//======================== Purchase =====================================
	//========================================================================
	//211027~211028 추가부분
	
	public static void addPurchseGetTest() throws Exception {
		JSONObject jsonObject = HttpGETConnection("/purchase/json/addPurchase/10001");
	
		ObjectMapper objectMapper = new ObjectMapper();
		Product product = objectMapper.readValue(jsonObject.toString(), Product.class);
		System.out.println(product);
	}
	
	public static void addPurchsePostTest() throws Exception {
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
		product.setProdNo(10001);
		user.setUserId("user12");
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("dbdbdb");
		purchase.setReceiverPhone("010-4444-4444");
		purchase.setDivyAddr("종각");
		//purchase.setTranCode("1");
		purchase.setMemberCheck("1");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("domain", purchase);
		
		JSONObject jsonObject = HttpPOSTConnection("/purchase/json/addPurchase", map);
		
		ObjectMapper objectMapper = new ObjectMapper();
		Purchase returnPurchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		System.out.println(returnPurchase);
	}
	
	public static void getPurchseGetTest() throws Exception {
		
		JSONObject jsonObject = HttpGETConnection("/purchase/json/getPurchase/10000");
		
		ObjectMapper objectMapper = new ObjectMapper();
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		System.out.println(purchase);
	}
	
	public static void updatePurchseGetTest() throws Exception {
		
		JSONObject jsonObject = HttpGETConnection("/purchase/json/updatePurchase/10000");
		
		ObjectMapper objectMapper = new ObjectMapper();
		Purchase purchase = objectMapper.readValue(jsonObject.toString(), Purchase.class);
		System.out.println(purchase);
		
	}
	
	//================== 공통 모듈 (GET, POST Connection) ====================
	private static JSONObject HttpGETConnection(String uri) throws Exception {
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8070" + uri;
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		// HttpResponse : Http Protocol 응답 Message 추상화
		HttpResponse httpResponse = httpClient.execute(httpGet);
				
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
		
//		System.out.println("[ Server 에서 받은 Data 확인 ] ");
//		String serverData = br.readLine();
//		System.out.println(serverData);
	
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println("::::"  + jsonobj);
		
		return jsonobj;
	}
	
	
	private static JSONObject HttpPOSTConnection(String uri, Map<String, Object> map) throws Exception {
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8070" + uri;
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");

		
		HttpEntity httpEntity01 = null;
		
		if (map.get("json") != null) {
			httpEntity01 = new StringEntity(map.get("json").toString(),"utf-8");
		} else {
			ObjectMapper objectMapper01 = new ObjectMapper();
			//Object ==> JSON Value 로 변환
			String jsonValue = objectMapper01.writeValueAsString(map.get("domain"));
			httpEntity01 = new StringEntity(jsonValue,"utf-8");
		}
		
		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		//System.out.println("[ Server 에서 받은 Data 확인 ] ");
		//String serverData = br.readLine();
		//System.out.println(serverData);
		
		//==> 내용읽기(JSON Value 확인)
		//JSONObject jsonobj = (JSONObject)JSONValue.parse(serverData);
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println("::::"  + jsonobj);
	
		return jsonobj;
	}
}




