<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../header.jsp" %>
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
    
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>
    <script>
    	$(document).ready(function(){
    		$('#id').focus();
    		var form2 = $('form#loginForm');
    		$(form2).submit(function(e){
    			if(id == ''){
    				alert('아이디를 입력해주세요');
    				$('#id').focus();
    				return;
    			}
    			if(pwd == ''){
    				alert('비밀번호를 입력해주세요');
    				$('#pwd').focus();
    				return;
    			}    											
    			var id = $('#id').val();
    			var pwd = $('#pwd').val(); 			
    			var formdata={"email": id, "pwd": pwd};
    			
    			document.loginForm.submit();
    		});
    	});
    </script>
  </head>
  <body>    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Login<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">로그인</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#Login</h2>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-md-12">
				<div class="wrapper">
					<div class="row no-gutters">
						<div class="col-md-7">
							<div class="contact-wrap w-100 p-md-5 p-4">
								<h3 class="mb-4">Login</h3>
								<form action="loginCheck.do" method="POST" id="loginForm" name="loginForm" class="contactForm">
									<div class="row">
										<div class="col-md-6">
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="label" for="subject">ID</label>
												<input type="text" class="form-control" name="id" id="id" placeholder="E-Mail">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<label class="label" for="password">Password</label>
												<input type="password" class="form-control" name="pwd" id="pwd" placeholder="password">
											</div>
										</div><br>
										<div class="col-md-12">
											<div class="form-group"><br>
												<input type="submit" value="Login" class="btn btn-primary" id='login-Btn'>
												<div class="submitting"></div>
											</div>
										</div>
                      <div><br>
                        <span><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;아이디 찾기 </a></span>
                        <span><a href="#">| 비밀번호 찾기 </a></span>
                        <span><a href="goSignupM.do">| 회원가입</a></span>
                      </div>										
									</div>
								</form>
							</div>
						</div>
						<div class="col-md-5 d-flex align-items-stretch">
							<div class="info-wrap w-100 p-5 img" style="background-image: url(images/img.jpg);"></div>
						</div>
					</div>
				</div>
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