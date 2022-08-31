<%@ page contentType="text/html; charset=EUC-KR"
		pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>��ǰ �����ȸ</title>

<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	img {
  		width: 300px;
  		height: 150px;
  		object-fit: contain;
	}

	  body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">
	
	function fncGetProductList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	$(function() {
		 
		//==> �˻� Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
		$( "button" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
			fncGetProductList(1);
		});

		$( "td:nth-child(4)" ).on("click" , function() {
			var prodNo = $(this).parent().find('input').val();
			
			if('${param.menu}'=='manage'){
				self.location ="/product/updateProductView?prodNo="+prodNo+"&menu=manage";
			}else if('${param.menu}'=='search'){
				self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
			}	
		});
		
		$( "td.prodNo" ).on("mouseover" , function() {
			
			
			//alert( $(this).data('prodno') );
			
			var prodNo = $(this).data('prodno');
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {
							
							var displayValue = "<h5>"
											+"��ǰ��ȣ		: "+JSONData.prodNo+"<br/>"
											+"��ǰ��		: "+JSONData.prodName+"<br/>"
											+"��ǰ�����̸�	: "+JSONData.fileName+"<br/>"
											+"������		: "+JSONData.prodDetail+"<br/>"
											+"��������		: "+JSONData.manuDate+"<br/>"
											+"����		: "+JSONData.price+"<br/>"
											+"��ǰ�̹���	: "
											+"<img src='/images/uploadFiles/"+JSONData.fileName+"' align='absmiddle'  class='img-thumbnail'/>"
											+"<br/><br/>"							
											+"</h5>";
				//Debug...									
				//alert(displayValue);
				$("h5").remove();
				$("#"+prodNo+"").html(displayValue); 
			}
		});
	});
		
		
		$( "td:nth-child(2)" ).css("color" , "blue");
		$("h5").css("color" , "blue");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
	});		
</script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
	
		<div class="page-header text-info">
			  <h3>��ǰ�����ȸ</h3>
		</div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">			
							
		 <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		 </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition == '0' ? "selected" : ""}>��ǰ��ȣ</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition == '1' ? "selected" : ""}>��ǰ��</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition == '2' ? "selected" : ""}>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
	    	</div>
		</div>

	<br/><br/>

	<table class="table table-hover table-striped" >
      
        <thead>
          <tr class = "success">
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">
           <c:if test="${ param.menu == 'manage' }">
			����
			</c:if>
			<c:if test="${ param.menu == 'search' }">
			����
			</c:if>
            </th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
			
			<c:set var="i" value="0" />
			<c:forEach var="product" items="${ list }">
				<c:set var="i" value="${ i+1 }"/>
				
				<tr>
				<td align="center"> ${i}</td>
				<td align="left" title="Click : ��ǰ���� Ȯ��">
		 		${product.prodName}
			 	</td>
				<td align="left">${product.price}</td>
				<td align="left" class="status">
				<c:if test= "${ empty product.proTranCode || product.proTranCode == '0  '}">
					<c:if test="${ param.menu == 'manage' }">
					<i class="glyphicon glyphicon-pencil">�����ϱ�</i>
<!-- 					<button type="button" class="btn btn-default">����</button>	 -->
					</c:if>
					<c:if test="${ param.menu == 'search' }">
					<i class="glyphicon glyphicon-shopping-cart" > �����ϱ�</i>
					
<!-- 					<button type="button" class="btn btn-default">����</button> -->
					</c:if>
				</c:if>
				</td>
				<td align="left" class="status2">
				<c:if test="${ param.menu == 'manage' }">
				<c:if test="${ product.proTranCode == 'SEL' || product.proTranCode == null }">
					�Ǹ���
				</c:if>
				
				<c:if test="${ product.proTranCode == 'SOL' }">
					���ſϷ�
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="/updateTranCodeByProd.do?prodNo=${product.prodNo}tranCode=DLI">    ����ϱ�</a>
				</c:if>
				
				<c:if test="${ product.proTranCode == 'DLI' }">
					�����
				</c:if>
				
				<c:if test="${ product.proTranCode == 'DLC' }">
					��ۿϷ� 
				</c:if>
			</c:if>
			
			<c:if test="${ param.menu == 'search' }">
				<c:if test="${ product.proTranCode == 'SEL' || product.proTranCode == null}">
					 �Ǹ���
				</c:if>
				<c:if test="${ product.proTranCode == 'SOL' }">
					 ������
				</c:if>
			</c:if>
				</td>
				<td align="left" data-prodno="${product.prodNo}" class="prodNo">
					<i class="glyphicon glyphicon-zoom-in" id= "${product.prodNo}"></i>
					<input class="prodNo" name="prodNo" type="hidden" value="${product.prodNo}">
				</td>	
			</tr>
			</c:forEach>
		
		</tbody>		
	</table>

<!--  ������ Navigator �� -->
</div>
	
	<div class="container text-center">
		 
		 <nav>
		  <!-- ũ������ :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== ���� nav -->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
		      <a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  �߾�  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  ���� page ����ų��� : active -->
				    <li class="active">
				    	<a href="javascript:fncGetProductList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<a href="javascript:fncGetProductList('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  ���� nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		      <a href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div>
 

<div class="container">
		<nav>
		  <ul class="pager">
		    <li><a href="#">Previous</a></li>
		    <li><a href="#">Next</a></li>
		  </ul>
		</nav>
</div>


<div class="container">
		<nav>
		  <ul class="pager">
		    <li class="previous disabled"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>
		    <!-- <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>  -->
		    <li class="next"><a href="#">Newer <span aria-hidden="true">&rarr;</span></a></li>
		  </ul>
		</nav>
</div>

</body>
</html>