<%@ page contentType="text/html; charset=EUC-KR" 
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<head>
<meta charset="EUC-KR">

<!-- ���� : http://getbootstrap.com/css/   ���� -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<script type="text/javascript" src="/javascript/calendar.js"></script>

<style>
body {
	padding-top: 50px;
}
</style>
<script type="text/javascript">

function fncUpdateProduct(){
	//Form ��ȿ�� ����
 	//var name = document.detailForm.prodName.value;
	//var detail = document.detailForm.prodDetail.value;
	//var manuDate = document.detailForm.manuDate.value;
	//var price = document.detailForm.price.value;
	
	var name = $("input[name='prodName']").val();
	var detail = $("input[name='prodDetail']").val();
	var manuDate = $("input[name='manuDate']").val();
	var price = $("input[name='price']").val();

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
		
	//document.detailForm.action='/product/updateProduct';
	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
}

	$(function() {
		$("td.ct_btn01").css("color", "red");
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	 	$( "button.btn.btn-primary" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('����')" ).html() );
			fncUpdateProduct();
		});
	});	

	$(function() {
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
		 $( "a[href='#' ]" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('����')" ).html() );
			$("form")[0].reset();
		});
	});	

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="page-header text-center">
			<h3 class=" text-info">��ǰ��������</h3>
			<h5 class="text-muted">
				��ǰ ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.
			</h5>
		</div>

		<form class="form-horizontal">

			<input type="hidden" name="prodNo" value="${ product.prodNo }" />

			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName"
						name="prodName" value="${ product.prodName }" placeholder="�����ǰ�̸�">
				</div>
			</div>

			<div class="form-group">
				<label for="prodDetail"
					class="col-sm-offset-1 col-sm-3 control-label"> ��ǰ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail"
						name="prodDetail" value="${ product.prodDetail }"
						placeholder="��ǰ������">
				</div>
			</div>

			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate"
						name="manuDate" value="${ product.manuDate }" placeholder="��������">
				</div>
				<div class="col-sm-3">
					<img src="../images/ct_icon_date.gif" width="30" height="30"
						onclick="show_calendar('manuDate', manuDate.value)" />
				</div>
			</div>

			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price"
						value="${product.price }" placeholder="����">
				</div>
			</div>

			<div class="form-group">
				<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="fileName"
						name="fileName" value="${ product.fileName }" placeholder="��ǰ����">
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" class="btn btn-primary">�� &nbsp;��</button>
					<a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
				</div>
			</div>
		</form>

	</div>
</body>

</html>