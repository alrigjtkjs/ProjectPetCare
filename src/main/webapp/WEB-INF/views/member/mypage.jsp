<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>My Page</title>
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
    	$(function(){
    		var email = '<%=(String)session.getAttribute("email")%>';
    		
			$.ajax({
    			url: "../member/checkPet.do",
    			type: "GET",
    			data: {email: email},
    			dataType: "json",
    			success: function(data){
    				if(!data){
						alert("등록된 친구가 아직 없습니다");
						return false;
					}
    				
    				var html = "<div class='card-group'>";
    				$(data).each(function(){
						html += "<div class='card' style='width: 10rem;''><img src=''/images/person_2.jpg' class='card-img-top' alt='image'><div class='card-body'>";
						html += "<h5 class='card-title'>"+this.name+"</h5>";
						html += "<h6 class='card-subtitle mb-2 text-muted'>"+this.kind+" / "+this.breed+"</h6>";
						html += "<p class='card-text'>"+this.sex+"</p><ul class='list-group list-group-flush'>";
						html += "<li class='list-group-item'>크기 : "+this.big+"</li>";
						html += "<li class='list-group-item'>생일 : "+this.bdate+"</li>";
						html += "</ul></div><div class='card-footer text-muted'>";
						html += '<button type="submit" id="updatePET-Btn" onclick="'+"location.href = '/member/updatePinfo.do?petseq="+this.petseq+"'"+'">수정하기</button>';
						html += '<button type="submit" id="'+this.petseq+'" class="deleteP")>삭제하기</button></div></div>';
    				});  
    				html += "</div>";
    				$("#container").html(html);
    				$('.deleteP').on("click", function(){
    	    			var id = $(this).attr('id');
    	    			console.log("#seq: "+id);
    	    			$.ajax({
    	    				url: "deleteP.do?petseq="+id,
    	    				type: "GET",
    	    				success: function(){
    	    					alert("정보가 삭제 되었습니다");
    	    					document.location.reload();
    	    				}
    	    			});
    	    		});
    			}
    		});
			
    		$('#deleteM').click(function(){
    			var email = "${sessionScope.email}";
    			console.log(email);
    			$.ajax({
    				url: "deleteM.do",
    				type: "GET",
    				data: {email : email},
    				success: function(){
    					location.href='/';
    				}
    			});
    		});
    		
    		var info = "${memberone}";
    		$('#myinfo-Btn').click(function(){
    			console.log("#ININFO: "+info);
    			$.ajax({
    				url: "myinfo.do",
    				type: "post", 
    				data: {info: info},
    				success: function(data){
    					alert('넘어감');
    				}
    			});
    		});
    	});
    </script>    
  </head>
  <body>
	<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>My Page<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">${sessionScope.email}님의 정보</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#My Page</h2>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-md-12">
				<div class="wrapper">
					<div class="row no-gutters">
						<div class="col-md-5 d-flex align-items-stretch">
							<div class="info-wrap w-100 p-5">
								<h3 class="mb-4">회원정보</h3>
								<button type="submit" id="myinfo-Btn" onclick="location.href = '/member/myinfo.do?email=${sessionScope.email}'">수정</button>	
								<div class="card" style="width: 18rem;">
								<img src="/images/person_2.jpg" class="card-img-top" alt="image">
								<div class="card-body">
								    <h5 class="card-title">${memberone.nickname} 님</h5>
								    <h6 class="card-subtitle mb-2 text-muted">${memberone.email}</h6>
								    <p class="card-text">회원정보</p>
								    <ul class="list-group list-group-flush">
									    <li class="list-group-item">만족도 : ${memberone.sat}</li>
									</ul>
								  </div>
								  <div class="card-footer text-muted">
								  	가입일 : ${memberone.joindate}
								  </div>
							</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="contact-wrap w-100 p-md-5 p-4">
								<h4 class="mb-4">
								나의 반려동물
								<button type="submit" id="signupPET-Btn" onclick="location.href = '/member/goSignupP.do'">등록하기</button>
								</h4>								
								<div id="container"></div>	
								<hr><span id="deleteM" class="btn btn-link text-secondary p-0">회원탈퇴</span>						
							</div>
						</div>
					</div>
				</div>
				<button type="submit" id="address" onclick="location.href = '/address/setting'">동네설정</button>	
			</div>
		</div>
    </div>
    </section>  
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/js/trim.js"></script>
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