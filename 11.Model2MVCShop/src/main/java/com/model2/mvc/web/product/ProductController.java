package com.model2.mvc.web.product;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
		// TODO Auto-generated constructor stub
	}

	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
		
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping(value="addProductView", method=RequestMethod.GET)
	public String addProduct( ) throws Exception {
		System.out.println("/product/addProduct : GET");
		
		//productService.insertProduct(product);
		
		//model.addAttribute("product", product);
		
		return "forward:/product/addProductVIew.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product, Model model ) throws Exception {
		System.out.println("/product/addProduct : GET");
		
		product.setProTranCode("SEL");
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.insertProduct(product);
		
		model.addAttribute("product", product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct(@RequestParam("prodNo") int prodNo,  HttpServletRequest request, HttpServletResponse response, Model model ) throws Exception {
		
		String strProdNo = Integer.toString(prodNo);

		Cookie[] cookies = request.getCookies();
		if(cookies!=null && cookies.length>0) {
		  for(int i=0;i<cookies.length;i++) {	
			  Cookie cookie = cookies[i];
			if(cookie.getName().equals("history")) {
				
				String historyCookie = URLDecoder.decode(cookie.getValue(), "euc-kr") ;
				//System.out.println("history Cookie value"+cookie.getValue());
				//historyCookie = cookie.getValue()+","+prodNo);
				cookie.setValue (URLEncoder.encode((historyCookie+","+strProdNo), "euc-kr"));
				cookie.setMaxAge(60*60);
				cookie.setPath("/");
				response.addCookie(cookie);
			}else{
			cookie = new Cookie("history", strProdNo);
			cookie.setMaxAge(60*60);
			cookie.setPath("/");
			response.addCookie(cookie);
			}
		  }
		}
		
		Product product = productService.findProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
		
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("prductList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{
		System.out.println("/updateProduct : GET");
		//Business Logic
		Product product = productService.findProduct(prodNo);
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("prduct") Product product , Model model ) throws Exception{
		System.out.println("/updateProduct : POST");
		//Business Logic
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=manage";
	}

	//@RequestMapping("/updateProductView.do")
	@RequestMapping( value="updateProductView", method=RequestMethod.GET )
	public String updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		
		System.out.println("/updateProductView : GET");
		
		Product product = productService.findProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
}
