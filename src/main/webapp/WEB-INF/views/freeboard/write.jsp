<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- WYSWYG/Quill -->
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
   
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
#page-title{
	margin-bottom:20px;
}
.content{
	height:200px;
}
</style>
 </head>
  
  <body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Free Board<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">자유 게시판</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<h3><span>게시물 작성</span></h3>
		    <form action="write" method="post">
	    	<div class="form-group">
				<label><b>작성자</b></label>
				<input type="text" class="form-control" name="email" id="email" value="${sessionScope.email}" readonly/>
			</div>
			<div>
				<label><b>제목</b></label>
				<input type="text" class="form-control" name="title" id="title" placeholder="제목을 작성해주세요"/>
			</div>
			<div class="form-group">
				<label><b>내용</b></label>
				<textarea class="form-control" name="content" id="content" rows="5" placeholder="자유롭게 글을 작성할 수 있습니다.명예훼손이나 상대방을 비방/불쾌감을 주는 글/욕설/남을 모욕하는 글은 임의로 제제가 있을 수 있습니다."></textarea>
				<!--위지윅id="editor-container" -->
			</div> 
            <div class="write-btn" align="right">
	            <button class="btn btn-primary btn-outline-primary btn-sm" type="submit">작성</button>
				<button class="btn btn-primary btn-outline-primary btn-sm" type="button" onclick="location.href='/freeboard/list'">목록</button>
			</div>
	    </form>
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
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <script src="/js/bootstrap-datepicker.js"></script>
  <script src="/js/jquery.timepicker.min.js"></script>
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>
  <!-- WYSWYG/Quill script -->
  <script>
	var quill = new Quill(
		'#editor-container',
		{
			modules : {
				toolbar : [ 
					[ {	header : [ 1, 2, false ] } ], 
					[ 'bold', 'italic', 'underline' ],
					[ 'image', 'code-block' ] 
			]},
			placeholder : '자유롭게 글을 작성할 수 있습니다.명예훼손이나 상대방을 비방/불쾌감을 주는 글/욕설/남을 모욕하는 글은 임의로 제제가 있을 수 있습니다.',
			theme : 'snow'
	});
  </script>
</body>
</html>