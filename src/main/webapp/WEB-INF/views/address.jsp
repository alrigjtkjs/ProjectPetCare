<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*, com.petcare.domain.Address" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">    
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/animate.css">   
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    <!-- 부트스트랩 아이콘 스타일시트 추가-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <!-- <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script> -->
    <!-- 검색자동완성 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">

		function sendXY(lat,lon){
			$.ajax({
				url: "../addressdo.json",
				type: "GET",
				data: {y:lat,x:lon},
				dataType:'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					alert(data.mydong);
					console.log("data:::"+data.mydong);
					var mydong = $('#mydong').text();
					var html = "";
					html += '<p id="mydongButton">';
					html += data.mydong;
					html += '<button type="submit" id="cancel" onclick="cancelDong();"><i class="bi bi-x-circle"></i></button></p>';
					$("#mydong").html(html);
				},
				error: function (request, status, error) {
			        console.log("code: " + request.status)
			        console.log("message: " + request.responseText)
			        console.log("error: " + error);
			    }
			});
		  }

  
		  $(function(){
			    $("#roadFullAddr").autocomplete({
			        source : function( request, response ) {
			             $.ajax({
			                    type: 'post',
			                    url: "../autoData.json",
			                    dataType: "json",
			                    data: { addr : $("#roadFullAddr").val()},
			                    success: function(data) {
			                        response(
			                            $.map(data, function(item) {
			                            	console.log(item);
												return {
														label: item.address_name, 
														value: item.address_name,
														x:item.x,
														y:item.y
												}		                               
			                            })
			                        );
			                    }
			               });
			            },
			        //조회를 위한 최소글자수
			        minLength: 2,
			        select: function( event, ui ) {
		            	alert("선택된 아이템: " + ui.item.value);
		            	sendXY(ui.item.y,ui.item.x);
			        }
			    });
			});
    </script>
    
    <style>
    .inputAddr{
    height:250px;
    width:1000px;
    }
    .inputAddr #searchCurr{
    width:50%;
    background-color:#68de7c;
    border-color:#68de7c;
    color:white;
    }
    #dong{
    background-color:gray;
    color:white;
    width:180px;
    border-radius: 5px;
    text-align:center;
    }
    #mydongButton{
    background-color:orange;
    color:white;
    width:180px;
    border-radius: 5px;
    text-align:center;
    }
    .rangeAddr{
    width:40%;
    }
    #cancel{
   background-color: transparent !important;
   background-image: none !important;
   border-color: transparent;
   border: none;
   color: #FFFFFF;

    }

    </style>
  </head>
<body>
<%@include file="header.jsp" %>
    
    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    		<div class="inputAddr">
	    		<p>동네 설정</p>
	    		<div class="input-group w-50">
		    		<button type="button" class="btn btn-outline-secondary">
		                  <i class="bi bi-search"></i>
		            </button>
					<input id=roadFullAddr type="text" class="form-control" placeholder="내 동네 이름(동,읍,면)으로 검색">
	            </div>
    			<button type="button" id="searchCurr" onclick="searchCurrAddr()">
    				<i class="bi bi-geo-alt"></i>현재 위치로 찾기
    			</button>
    		</div>
    		<div class="myAddr">
    			<p>내가 설정한 동네</p>		
				<div id="mydong">
				<c:choose>
	    			<c:when test="${empty mydong}">
	    				<a href="#">내 동네 설정하러 가기</a>
	    			</c:when>
	    			<c:otherwise>
	    				<p id="mydongButton">
	    				${mydong}
	    				<button id="cancel" onclick="cancelDong();"><i class="bi bi-x-circle"></i></button>
	    				</p>
	    			</c:otherwise>
    			</c:choose>
    			</div>    				
    			<div id="dong"></div>
    		</div>
    		<div class="nearAddr" style="height:100%;">
    			<p>동네 범위 설정</p>
    			<div class="rangeAddr">
					<input type="range" class="custom-range" min="0" max="2">
					<div class="rangeAddrText">
						<span>내동네</span>
						<span style="display: inline-block; width:40%;text-align:right;">|</span>
						<span style="display: inline-block; width:45%;text-align:right;">근처동네</span>
					</div>
				</div>
				<div>
					<div class="showNearDong">
					<p>근처 동네</p>					
					<a href="" id="showBtn" type="submit">근처 동네 보기</a>
					<a href="" id="foldBtn" style="display:none">근처 동네 접기</a> 
					<div style="display:none">
					<c:forEach items="${nearlist}" var="list">
						<p>${list}</p>
					</c:forEach>
					</div>		
					</div>
    			</div>
    		</div>  		
        </div>
    </section>
  
  <%@include file="footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script>
	/*현재 위치 좌표 얻기*/
	function searchCurrAddr(){
		getLocation();
	}
	function getLocation() {
		  if (navigator.geolocation) { // GPS를 지원하면
		    navigator.geolocation.getCurrentPosition(function(position) {
		      alert(position.coords.latitude + ' ' + position.coords.longitude);
		      sendXY(position.coords.latitude,position.coords.longitude);
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS를 지원하지 않습니다');
		  }
		}
	/*설정한 내 동네 삭제*/
	function cancelDong(){
		$.ajax({
			url: "../addressCancel.json",
			type: "GET",
			success: function(data){
				alert("취소성공!");
				$("#mydong").empty();
				var html="";
				html += '<a href="#">내 동네 설정하러 가기</a>';
				$("#mydong").html(html);
			}
		});	
	}
	$("#showBtn").click(function() {
        $(this).nextUntil('.showNearDong').toggle();
        $(this).hide();
        $(this).next().show();
        return false;
    });
    $("#foldBtn").click(function() {
        $(this).nextUntil('.showNearDong').toggle();
        $(this).hide();
        $(this).prev().show();
        return false;
    });
    
   
	
</script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <script src="/js/bootstrap-datepicker.js"></script>
  <script src="/js/jquery.timepicker.min.js"></script>
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script> 
  </body>
</html>