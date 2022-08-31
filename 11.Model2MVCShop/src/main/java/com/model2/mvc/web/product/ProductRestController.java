package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
	public ProductRestController() {
		System.out.println(this.getClass());
		// TODO Auto-generated constructor stub
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
		
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public Product addProduct(@RequestBody Product product) throws Exception {
		System.out.println("/product/json/addProduct : GET");
		
		product.setProTranCode("SEL");
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.insertProduct(product);
		
		return product;
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct(@PathVariable int prodNo ) throws Exception {
		
		System.out.println("/product/json/getProduct : GET");
		
		/*
		Cookie[] cookies = request.getCookies();
		if(cookies!=null && cookies.length>0) {
		  for(int i=0;i<cookies.length;i++) {	
			  Cookie cookie = cookies[i];
			if(cookie.getName().equals("history")) {
				
				String historyCookie = URLDecoder.decode(cookie.getValue(), "euc-kr") ;
				//System.out.println("history Cookie value"+cookie.getValue());
				//historyCookie = cookie.getValue()+","+prodNo);
				cookie.setValue (URLEncoder.encode((historyCookie+","+prodNo), "euc-kr"));
				cookie.setMaxAge(60*60);
				response.addCookie(cookie);
			}else{
			cookie = new Cookie("history",request.getParameter("prodNo"));
			cookie.setMaxAge(60*60);
			response.addCookie(cookie);
			}
		  }
		}
		*/
				
		return productService.findProduct(prodNo);
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="json/listProduct" , method=RequestMethod.POST)
	public Map<String, Object> listProduct( @RequestBody Search search) throws Exception{
		
		System.out.println("/product/json/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", map.get("prductList"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Product updateProduct( @RequestBody Product product) throws Exception{
		System.out.println("/product/json/updateProduct : POST");
		//Business Logic
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		productService.updateProduct(product);
		
		return product;
	}

	@RequestMapping( value="json/updateProductView", method=RequestMethod.GET )
	public Product updateProductView(@PathVariable int prodNol) throws Exception{
		
		System.out.println("product/json/updateProductView : GET");
		
		Product product = productService.findProduct(prodNol);

		return product;
	}

}
