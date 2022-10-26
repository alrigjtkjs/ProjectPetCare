<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
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
    
    <style>
    
    .admincontainer {
	  width: 100%;
	  padding-right: 15px;
	  padding-left: 15px;
	  margin-right: auto;
	  margin-left: auto; }
	  @media (min-width: 576px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 768px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 992px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 1200px) {
	    .admincontainer {
	      max-width: 80%; } }
    
    .gridcontainer{
    	row-gap: 10px;
    	column-gap: 10px;
    	display: grid;
		grid-template-columns: 1fr 1fr;
    }
    .boardview{
    	width:100%;
    }
    .boardview thead{
    	text-align: center;
    	border:1px solid black;
    	font-weight: bold;
	  	vertical-align: top;
	  	border-right: 1px solid #ccc;
	  	border-bottom: 2px solid #ccc;
	  	border-top: 1px solid #fff;
	  	border-left: 1px solid #fff;
	  	background: #EEF2F3;
    }
    #addition{
    	float:right;
    }
    table.boardview td {
	  	width: 350px;
	  	padding: 10px;
	 	vertical-align: top;
	  	border-right: 1px solid #ccc;
	  	border-left: 1px solid #ccc;
	  	border-bottom: 1px solid #ccc;
	}
	.admin-main-board{
	  	border-radius: 16px;
	  	box-shadow: inset 0 0 8px #D6E6F5;
		padding: 2em 2em; 
		margin: 2em 0; 
		font-weight: bold; 
		color: #000000; 
		background: #FFF; 
		border: solid 3px #D6E6F5;
	}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>

    
    <section class="ftco-section bg-light">
    <div class="admincontainer">
    <div class="notation">
    	<h3>신고/문의 현황판</h3>
    	<div class="admin-main-board">
    	돌보미0 돌봄 후기0 나눔 마켓2 <br>자유게시판3 공지사항1 신고3
    	</div>
    </div>
    <div class="gridcontainer">
    <div class="item">
    	<h3>공지사항</h3><a href="../info/list.do" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	<div class="item">
    	<h3>자유게시판</h3><a href="../freeboard/list.do" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    <div class="item">
    	<h3>우리동네 돌보미</h3><a href="../dolbom/list.do" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->    	
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->    	
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	<div class="item">
    	<h3>유저관리</h3><a href="" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	 <div class="item">
    	<h3>돌봄후기</h3><a href="../review/list.do" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	<div class="item">
    	<h3>나눔 마켓</h3><a href="../market/list.do" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	<div class="item">
    	<h3>신고</h3><a href="" id="addition">더보기</a>
    	<table class="boardview">
    	<thead>
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<th>신고일자</th>
    	<th>신고자</th>
    	</tr>
    	</thead>
    	<tbody>
    	<tr>
    	<td>신고 번호</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호2</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	<tr>
    	<td>신고 번호3</td>
    	<td><a href="#">신고 작성자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	<td><a href="#">신고 제목</a></td> <!-- 글로 직접이동 -->
    	<td>신고 작성일자</td>
    	<td>신고일자</td>
    	<td><a href="#">신고자</a></td> <!-- 해당유저 관리 페이지로 이동 -->
    	</tr>
    	</tbody>
    	</table>
    	</div>
    	</div>
    </div>
    </section>



  
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="/js/jquery.min.js"></script>
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script>
  <script src="/js/main.js"></script>

    
  </body>
</html>