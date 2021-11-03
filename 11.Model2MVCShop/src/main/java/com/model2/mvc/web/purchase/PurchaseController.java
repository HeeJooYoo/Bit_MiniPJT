package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	public PurchaseController() {
		// TODO Auto-generated constructor stub
		System.out.println(getClass());
	}
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public String addPurchase(@RequestParam("prod_no") int prodNo, Model model) throws Exception {
		
		System.out.println("addPurchaseView_prodNo :: " + prodNo);
		
		model.addAttribute("product", productService.getProduct(prodNo));
		
		return "forward:addPurchaseView.jsp";
	}
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public String addPurchase(@ModelAttribute Purchase purchase, HttpSession session) throws Exception {
		
		User user = (User)session.getAttribute("user");
		Product product = (Product)session.getAttribute("product");
		
		System.out.println("addPurchase_user :: " + user);
		System.out.println("addPurchase_product :: " + product);
		
		if (user == null) {
			user = new User();
		}
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		System.out.println("addPurchase_purchase :: " + purchase);
		
		if (purchaseService.addPurchase(purchase) == 1) {
			System.out.println("addPurchase :: ���� �Ϸ�");
		}
		
		return "forward:addPurchase.jsp";
	}
	
	@RequestMapping(value = "getPurchase", method = RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("addPurchaseView_tranNo :: " + tranNo);
		
		model.addAttribute("purchase", purchaseService.getPurchase(tranNo));
		
		return "forward:getPurchase.jsp";
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("updatePurchaseView_tranNo :: " + tranNo);
		
		model.addAttribute("purchase", purchaseService.getPurchase(tranNo));
		
		return "forward:updatePurchaseView.jsp";
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST)
	public String updatePurchase(@ModelAttribute Purchase purchase, Model model) throws Exception {
		
		System.out.println("updatePurchase_purchase :: " + purchase);
		
		if (purchaseService.updatePurcahse(purchase) == 1) {
			System.out.println("���� ������Ʈ ����");
		}
		
		purchase = purchaseService.getPurchase(purchase.getTranNo()); 
		System.out.println("updatePurchase_getPurchase :: " + purchase);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:updatePurchase.jsp";
	}
	
	@RequestMapping(value = "updateTranCodeByProd", method = RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode, HttpServletRequest request) throws Exception {
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		
		product.setProdNo(prodNo);
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(product);
		
		if (purchaseService.updateTranCode(purchase) == 1) {
			System.out.println("���� �ڵ� ������Ʈ ����");
		}
		
		System.out.println("guestName :: " + request.getParameter("guestName"));
		System.out.println("guestPhone :: " + request.getParameter("guestPhone"));
		
		if ("2".equals(tranCode)) {
			return "forward:/product/listProduct?menu=manage";
		} 
		
		return "forward:/purchase/listPurchase?guestName="+request.getParameter("guestName")+"&guestPhone="+request.getParameter("guestPhone");
	}

	@RequestMapping("listPurchase")
	public String listPurchase(@ModelAttribute Search search, HttpSession session, HttpServletRequest request, Model model) throws Exception {
		
		User user = (User)session.getAttribute("user");
		System.out.println(request.getParameter("searchOrder"));
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("user", user);
		map.put("order", request.getParameter("searchOrder"));
		map.put("guestName", request.getParameter("guestName"));
		map.put("guestPhone", request.getParameter("guestPhone"));
		
		purchaseService.getPurchaseList(map);
		
		List<Purchase> list = (List<Purchase>) map.get("list"); 

		for(int i=0 ; i < list.size() ; i++) {
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
		}
		
		map.put("list", list);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		if (request.getParameter("guestName") != null) {
			model.addAttribute("guestName", request.getParameter("guestName"));
			model.addAttribute("guestPhone", request.getParameter("guestPhone"));
		}
		
		return "forward:listPurchase.jsp";
	}
	
}
