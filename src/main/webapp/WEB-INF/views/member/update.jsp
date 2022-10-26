<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>
    <script>
   	var email = "${sessionScope.email}";
    var pwd;   
    var pwdCheck;
    var nickname;
    var name;
    var phone;
    var addr;
    
    var selectedImages = [];
	var savedImages = [];
	var imgNum = 0;
    $(document).ready(function(){
    	$("#userEmail").val("${memberone.email}");
    	$("#nickname").val("${memberone.nickname}");
    	$("#agree").val("${memberone.agree}");
    	$("#name").val("${memberone.name}");
    	$("#bdate").val("${memberone.bdate}");
    	
    	<c:forEach var="i" items="${files}">
		savedImages.push({fname: '${i.fname}', ofname: '${i.ofname}'});
		</c:forEach>
		
		if(savedImages != null){
			var html = "";
			savedImages.forEach(function(i, idx){
				html += "<img src='/market/display?imgName="+i.fname+"' title='"+i.ofname+"' class='col p-3 saved' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this,"+idx+");'>";
			});
			$("#imageList").append(html);
		}
		$("#upload").on("change", function(e){
			//$("#imageList").empty();
			
			var images = e.target.files;
			imageArr = Array.prototype.slice.call(images);
			/* 파일 확장자 체크
			for(var i=0; i<images.length; i++){
				if(!checkExtension(images[i].name, images[i].size)){
					return false;
				}
			}
			*/
			preview(imageArr);
		});
		//1. 비밀번호 확인
		var $resultMsg2 = $('#pwd-check-warn');
		$('#pwdCheck').keyup(function(){			
			$resultMsg2.html('비밀번호 확인란에 입력해주세요.');
			pwd = $('#pwd').val();
			pwdCheck = $('#pwdCheck').val();
			if(8<=pwd.length && pwd.length<=16){
				if(pwd.length === pwdCheck.length){
					if(pwd != pwdCheck){
						$resultMsg2.html('비밀번호가 일치하지않습니다.');
						$resultMsg2.css('color','red');
				        return;
					}else if(pwd.includes(' ')){
						$resultMsg2.html('공백은 포함될 수 없습니다.');
						$resultMsg2.css('color','red');
						return;
					}else{
						$resultMsg2.html('비밀번호가 일치합니다.');
						$resultMsg2.css('color','green');
						$('#nickname').focus();
				        return;
					}
				}
			}else{
				$resultMsg2.html('비밀번호는 8~16자로 정해주세요');
				$resultMsg2.css('color','red');
				return;
			}
		});
		//2. 닉네임 체크
		var $resultMsg3 = $('#nick-check-warn');
		$('#nickname').keyup(function(){
			$resultMsg3.html('');
			nickname = $('#nickname').val();
			if(nickname != null){
				if(15<nickname.length){
					$resultMsg3.html('닉네임은 15자 이내로 정해주세요');
					$resultMsg3.css('color','red');
					return;
				}else if(nickname.includes(' ')){
					$resultMsg3.html('공백은 포함될수 없습니다');
					$resultMsg3.css('color','red');
					return;
				}
			}
			$.ajax({
	    		url: 'nickCheck.do',
	    		type: 'post',
	    		data: {nick: nickname},
	    		success: function(data){
	    			console.log("data: "+data);
	    			if(data == "T"){
	    				$resultMsg3.html('중복된 닉네임입니다');
						$resultMsg3.css('color','red');
						return;
	    			}
	    		}	    		
	    	});
		});		
		// DB에 입력
		var form1 = $('form#contactForm');
		$(form1).submit(function(e){
			e.preventDefault();
			// 이미지
			for(var i=0; i<selectedImages.length; i++){
				if(selectedImages[i] != null){
					formData.append("multipartFiles", selectedImages[i]);
				}
			}
			for(var i=0, j=0; i<savedImages.length; i++){
				if(savedImages[i].ofname == null){
					formData.append("fnames["+j+"]", savedImages[i].fname);
					j++;
				}
			}
			//필수정보 기입여부 체크
			if(pwdCheck == null){
				alert('비밀번호를 기입해주세요');
				$('#pwd').focus();
				return false;
			}
			if(nickname == null){
				alert('닉네임을 기입해주세요');
				$('#nickname').focus();
				return false;
			}		
			//선택정보 유효성 체크			
			var phone2 = $('#phone2').val();
			var phone3 = $('#phone3').val();
			var regExpPhone = /[0-9]*$/;
			if(phone2 != "" && phone3 != ""){
				if(regExpPhone.test(phone2) && regExpPhone.test(phone3)){
					if((phone2.length == 3 || phone2.length == 4) && phone3.length == 4){
						phone = $('#phone1').val()+phone2+phone3;
					}else{
						alert('형식에 맞춰 작성해주세요');
					}
				}else{
					alert('전화번호에는 숫자만 써주세요');
				}
			}
			var name = $('#name').val();
			var regExpName = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			if(!regExpName.test(name) && name != ""){
				alert('한글이름을 띄어쓰기 없이 적어주세요');
				return false;
			}
			
			var addr1 = $('#addr1').val();
			var addr2 = $('#addr2').val();
			var addr3 = $('#addr3').val();
			var addr4 = $('#addr4').val();
			if(addr4 != null){
				addr = addr1+' '+addr2+' '+addr3+' '+addr4;
			}else{
				alert('세부사항을 입력해주세요');
			}			
			var formdata = 
			{
				"pwd": pwdCheck,
				"nickname": nickname,			
				"phone": phone,
				"name": name,
				"addr": addr,
				"email": email
			};
			$.ajax({
				type : 'POST',
				url : $(form1).attr('action'),
				data : JSON.stringify(formdata),
				contentType: "application/json; charset=UTF-8",
				success : function(){
					alert('수정 되었습니다.');
					location.href = '/member/mypage.do?email=${sessionScope.email}';
				}
			});
		});
		function preview(imageArr){
    		imageArr.forEach(function(i, idx){
    			if(i.type.match('image.*')){
    				var reader = new FileReader();
    				selectedImages.push(i);
    				reader.onload = function(e){
    					var html = "";
    					html += "<img src='"+e.target.result+"' title='"+i.name+"' class='col p-3 selected' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this, "+imgNum+");'>";
    					imgNum ++;
    					$("#imageList").append(html);
    				}
    				reader.readAsDataURL(i);
    			}else{
    				
    			}
    		});
    		$("#upload").val("");
    	}
    	function deleteClick(imgObj, i){
    		if($(imgObj).attr("class").includes("selected")){
    			selectedImages.splice(i, 1);
    		}else if($(imgObj).attr("class").includes("saved")){
    			//savedImages.splice(i, 1);
    			delete savedImages[i].ofname;
    			console.log(savedImages[i].ofname);
    		}
    		$(imgObj).remove();
    	}
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
          	<p class="breadcrumbs mb-2"><span>update<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">회원정보 수정</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#Update</h2>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-md-12">
				<div class="wrapper">
					<div class="row no-gutters">
						<div class="col-md-5 d-flex align-items-stretch">
							<div class="info-wrap w-100 p-5 img" style="background-image: url(images/img.jpg);"></div>
						</div>
						<div class="col-md-7">
							<div class="contact-wrap w-100 p-md-5 p-4">
								<h3 class="mb-4">Update</h3>
								<form action="updateM.do" method="POST" id="contactForm" name="contactForm" class="contactForm">
									<div class="row">
										<div class="col-md-6">
											<label>필수정보</label>
										</div>					
                      					<div class="col-md-12">
											<div class="form-group">
												 <label class="label" for="email">EMAIL</label>
												 <div class="input-group">												 	
													<input type="text" class="form-control" id="userEmail" disabled>
												</div>
											</div>
                     					 </div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="label" for="password">PASSWORD</label>
												<input type="password" class="form-control" id="pwd">
											</div>
                     					 </div>
					                      <div class="col-md-6">
					                        <div class="form-group">
												<label class="label" for="password" style="margin-bottom: 8px;"></label>
												<input type="password" class="form-control" id="pwdCheck" placeholder="Password Check">
											</div>
                      					</div>
                      					<span id="pwd-check-warn"></span>
                      					<div class='col-md-12'>
                      						<div class='row'>                      					                      					
		                      					<div class="col-md-4">
		                        					<div class="form-group">                        						
														<label class="label" for="subject">NICKNAME</label>
														<input type="text" class="form-control" id="nickname">
													</div>
		                      					</div>
		                      					<div class="col-md-4">
		                        					<div class="form-group">                        						
														<label class="label" for="subject">AGREE?</label>
														<input type="text" class="form-control" id="agree" disabled>
													</div>
		                      					</div>
											</div>     
										</div>             					
									</div>																			
									<div class="row">
										<div class="col-md-6"></div><br>					                      
					                      <div class="col-md-12">
                        					<div class="form-group">
                        						<hr>
                        						<label class="label" for="subject">선택정보</label><br>
												<label class="label" for="subject">이름</label>
												<small>NAME</small>
												<input type="text" class="form-control" id="name">
											</div>
                      					</div>
					                      <div class="col-md-12">
					                        <div class="form-group">
												<label class="label" for="bdate">BIRTHDAY</label>
												<input type="text" class="form-control" id="bdate" disabled>
											</div>
                      					</div>
				                        	<div class='col-md-4'>
					                          <div class="form-group">
					                            <label class="label" for="subject">PHONE NUMBER</label>					                            
					                            <select class="form-control" name="phone1" id="phone1">
												<option value='010'>010</option>
												<option value='011'>011</option>
												<option value='016'>016</option>
												<option value='019'>019</option>												
												</select>
											  </div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<input type="text" class="form-control" name="phone2" id="phone2">
												</div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<input type="text" class="form-control" name="phone3" id="phone3">
												</div>
					                        </div>
					                        <div class="col-md-4">
					                          <div class="form-group">
					                            <label class="label" for="subject">ADDRESS</label>
					                            <select class="form-control" name="addr1" id="addr1">
												<option value='서울'>서울</option>
												<option value='경기'>경기</option>
												<option value='인천'>인천</option>												
												</select>					                            
					                          </div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<select class="form-control" name="addr2" id="addr2">
													<option value='동구'>동구</option>
													<option value='서구'>서구</option>
													<option value='남구'>남구</option>												
												</select>
												</div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<select class="form-control" name="addr3" id="addr3">
													<option value='1동'>1동</option>
													<option value='2동'>2동</option>
													<option value='3동'>3동</option>												
												</select>
												</div>
					                        </div>
					                        <div class='col-md-12'>
					                        	<div class='form-group'>
													<input type="text" class="form-control" name="addr4" id="addr4" placeholder='세부정보'>
												</div>
					                        </div>
					                        <div class="col-md-12">
					                          <div class="form-group">
					                            <label class="label" for="subject">GENDER</label>&nbsp;&nbsp;&nbsp;&nbsp;
					                            <label>Man</label><input type="radio" name="gender" value="M">&nbsp;&nbsp;
					                            <label>Woman</label><input type="radio" name="gender" value="F">
					                          </div>
					                        </div>
					                        <div class="col-md-12">
												<div class="form-group">
													<label class="label" for="big">PHOTO</label>
													<input type="file" class="form-control" id="userphoto" multiple accept="">
													<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
												</div>
	                    					 </div>
											<div class="col-md-12">
												<div class="form-group">
													<input type="reset" value="다시 쓰기" class="btn btn-primary" />
													<input type="submit" value="Update" class="btn btn-primary">
													<div class="submitting"></div>
												</div>
											</div>
										</div>
									</form>
								</div>
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