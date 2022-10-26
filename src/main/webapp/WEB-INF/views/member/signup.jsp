<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
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
    
    <script>
    var email1;
    var email2;
    var email3; 
	var inputCode;
    var pwd;   
    var pwdCheck;
    var nickname;
    var agree;
    var bdate;
    var phone;
    var addr;
    
    var selectedImages = [];
	var imgNum = 0;
    $(document).ready(function(){
    	// 0.이미지 추가 로직 세팅
    	$("#userphoto").on("change", function(e){
			$("#imageList").empty();
			var images = e.target.files;
			imageArr = Array.prototype.slice.call(images);
			preview(imageArr);
		});
    	//1.이메일 체킹
    	var $resultMsg1 = $('#mail-check-warn');
    	$('#userEmail1').focus();
    	$('#mail-Check-Btn').click(function() {
    		var regExpEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/; //숫자,영대소,-_. 만 입력가능
	    	email1 = $('#userEmail1').val();
	    	if(email1 == ''){
	    		alert('이메일을 입력해주세요.');
	    		return false;
	    	}else if(!regExpEmail.test($('#userEmail1').val())){
	    		alert('이메일은 영어와 숫자로만 이루어져있습니다.');
	    		return false;
	    	}
	    	email2 = $('#userEmail2').val();	    	
	    	email3 = email1 + email2;
	    	$.ajax({
	    		url: 'emailCheck.do',
	    		type: 'post',
	    		data: {email: email3},
	    		async: false,
	    		success: function(data){
	    			console.log("data: "+data);
	    			if(data == "T"){
	    				$resultMsg1.html('중복된 이메일입니다');
						$resultMsg1.css('color','red');
						return false;
	    			}else{ //1.1 인증메일 보내기
	    				var checkInput = $('.mail-check-input'); 
	    				alert('인증번호가 전송되었습니다.');
	    				$resultMsg1.html('인증메일 가는중...');
	    				$resultMsg1.css('color','black');
	    				
	    				$.ajax({
	    					type : 'get',
	    					url :  '<c:url value ="/member/mailCheck?email="/>'+email3,
	    					success : function (data) {
	    						console.log("data : " +  data);
	    						checkInput.attr('disabled',false);
	    						code = data;
	    						$('#mail-check-input').focus();
	    						$resultMsg1.html('↑ 인증번호를 입력해주세요');
	    						$resultMsg1.css('color','blue');
	    					}			
	    				});
	    			}
	    		}	    		
	    	});
    	});
	 	//1.2 인증번호 비교		
		$('#mail-check-input').keyup(function(){	
			inputCode = $('#mail-check-input').val();
			if(inputCode.length === 6){
				if(inputCode === code && inputCode.length === 6){
					$resultMsg1.html('인증번호가 일치합니다.');
					$resultMsg1.css('color','green');
					$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
			        $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
			        $('#pwd').focus();
			        return true;
				}else{
					$resultMsg1.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
					$resultMsg1.css('color','red');
					return false;		
				}
			}
		});
		//2. 비밀번호 확인
		var $resultMsg2 = $('#pwd-check-warn');
		$('#pwdCheck').keyup(function(){			
			$resultMsg2.html('비밀번호 확인란에 입력해주세요 →');
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
		//3. 닉네임 체크
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
			//이미지
			var formdata = new FormData();
			
			for(var i=0; i<selectedImages.length; i++){
	    		if(selectedImages[i] != undefined){
	    			formdata.append("multipartFiles", selectedImages[i]);
	    		}
	    	}
			//필수정보 기입여부 체크
			if(inputCode == null){
				alert('이메일 인증을 받아야합니다');
				$('#userEmail1').focus();
				return false;
			}
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
			agree = $("input[name='agree']:checked").val();;
			if(agree == 'N'){
				alert('약관에 동의해야 가입가능합니다');
				$('#agree').focus();
				return false;
			}			
			//선택정보 유효성 체크
			var name = $('#name').val();
			var regExpName = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			if(!regExpName.test(name) && name != ""){
				alert('한글이름을 띄어쓰기 없이 적어주세요');
				return false;
			}
			
			bdate = null;
			if($('#byear').val() != ''){				
				if($('#bmonth').val() != ''){
					var bmonth = $('#bmonth').val();
					if(bmonth.length == 1){
						bmonth = '0'+bmonth;
					}
					if($('#bday').val() != ''){
						var bday = $('#bday').val();
						if(bday.length == 1){
							bday = '0'+bday;
						}
						bdate = $('#byear').val()+'-'+bmonth+'-'+bday;
					}
				}
			}		
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
			var addr1 = $('#addr1').val();
			var addr2 = $('#addr2').val();
			var addr3 = $('#addr3').val();
			var addr4 = $('#addr4').val();
			if(addr4 != null){
				addr = addr1+' '+addr2+' '+addr3+' '+addr4;
			}else{
				alert('세부사항을 입력해주세요');
			}
						
			var gender = $("input[name='gender']:checked").val();
			
			formdata.append("email", email3);
			formdata.append("pwd", pwdCheck);
			formdata.append("nickname", nickname);
			formdata.append("agree", agree);
			formdata.append("phone", phone);
			formdata.append("name", name);
			formdata.append("addr", addr);
			formdata.append("gender", gender);
			formdata.append("bdate", bdate);	
			//console.log("formdata"+formdata);
			//
			for (let value of formdata.values()) {
     			 console.log(value);
			}
			//
			$.ajax({
				type : 'POST',
				url : $(form1).attr('action'),
				data : formdata,
				processData : false,
				contentType: false,
				success : function(data){
					alert('회원가입 되었습니다.');
					location.href = '/member/login.do';
				}
			});
		});
		function preview(imageArr){
    		var html = "";
    		imageArr.forEach(function(i, idx){
    			if(i.type.match('image.*')){
    				var reader = new FileReader();
    				selectedImages.push(i);
    				reader.onload = function(e){
    					html += "<img src='"+e.target.result+"' title='"+i.name+"' class='col p-3' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this,"+imgNum+");'>";
    					$("imageList").html(html);
    					imgNum ++;
    				}
    				reader.readAsDataURL(i);
    			}else{}
    		});
    		$("#petphoto").val("");
    	}
    	function deleteClick(imgObj, i){
    		selectedImages.splice(i,1);
    		console.log(selectedImages[0]);
    		console.log(selectedImages[1]);
    		console.log(selectedImages[2]);
    		console.log(selectedImages[3]);
    		console.log(imgObj);
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
          	<p class="breadcrumbs mb-2"><span>Signup<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">회원가입</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#Sign Up</h2>
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
								<h3 class="mb-4">Sign Up</h3>
								<form action="signup.do" method="POST" id="contactForm" name="contactForm" class="contactForm">
									<div class="row">
										<div class="col-md-6">
											<label>필수정보 입력</label>
										</div>							
                      					<div class="col-md-12">
											<div class="form-group">
												 <label class="label" for="email">EMAIL</label>
												 <div class="input-group">												 	
													<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
													<select class="form-control" name="userEmail2" id="userEmail2" >
													<option>@example.com</option>
													<option>@naver.com</option>
													<option>@daum.net</option>
													<option>@gmail.com</option>
													<option>@hanmail.com</option>
													</select>
												</div>   
												<div class="input-group-addon">
													<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
												</div>
												<div class="mail-check-box">
													<input id='mail-check-input' class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
												</div>
												<span id="mail-check-warn"></span>
											</div>
                     					 </div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="label" for="password">PASSWORD</label>
												<input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password">
											</div>
                     					 </div>
					                      <div class="col-md-6">
					                        <div class="form-group">
												<label class="label" for="password" style="margin-bottom: 8px;"></label>
												<input type="password" class="form-control" name="pwdCheck" id="pwdCheck" placeholder="Password Check">
											</div>
                      					</div>
                      					<span id="pwd-check-warn"></span>
                      					<div class='col-md-12'>
                      						<div class='row'>                      					                      					
		                      					<div class="col-md-4">
		                        					<div class="form-group">                        						
														<label class="label" for="subject">NICKNAME</label>
														<input type="text" class="form-control" name="nickname" id="nickname" placeholder="Nickname">
													</div>
		                      					</div>
		                      					<div class="col-md-4">
		                        					<div class="form-group">                        						
														<label class="label" for="subject">AGREE?</label>&nbsp;&nbsp;&nbsp;&nbsp;
														<label>YES!;)</label><input type="radio" name="agree" value="Y">&nbsp;&nbsp;
					                            		<label>NOPE</label><input type="radio" name="agree" value="N">
													</div>
		                      					</div>                      					
		                      					<div class="col-md-4">
													<div class="form-group">												
														<input type="submit" id='submit-Btn' value="Sign Up" class="btn btn-primary"><br>
														<font size='2'>필수정보는 모두 써주세요</font>
													</div>
												</div>
												<span id="nick-check-warn"></span>
											</div>     
										</div>             					
									</div>																			
									<div class="row">
										<div class="col-md-6"></div><br>					                      
					                      <div class="col-md-12">
                        					<div class="form-group">
                        						<hr>
                        						<label class="label" for="subject">선택정보 입력</label><br>
												<label class="label" for="subject">이름</label>
												<small>NAME</small>
												<input type="text" class="form-control" name="name" id="name" placeholder="이름 Name">
											</div>
                      					</div>
					                      <div class="col-md-4">
					                        <div class="form-group">
												<label class="label" for="bdate">BIRTHDAY</label>
												<select class="form-control" name="byear" id="byear" >
													<option value="" selected='selected'>연도</option>
													<c:forEach begin='1930' end='2010' step='1' var='i'>
														<option>${i}</option>
													</c:forEach>
												</select>
											</div>
                      					</div>
					                      <div class="col-md-4">
					                        <div class="form-group">
					                          <select class="form-control" name="bmonth" id="bmonth" >
													<option value="" selected='selected'>월</option>
													<c:forEach begin='1' end='12' step='1' var='i'>
														<option>${i}</option>
													</c:forEach>
												</select>
					                        </div>
					                      </div>
					                        <div class="col-md-4" >
					                          <div class="form-group">
					                            <select class="form-control" name="bday" id="bday" >
													<option value="" selected='selected'>일</option>
													<c:forEach begin='1' end='31' step='1' var='i'>
														<option>${i}</option>
													</c:forEach>
												</select>
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
					                            <option value="" selected='selected'>시</option>
												<option value='서울'>서울</option>
												<option value='경기'>경기</option>
												<option value='인천'>인천</option>												
												</select>					                            
					                          </div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<select class="form-control" name="addr2" id="addr2">
													<option value="" selected='selected'>구</option>
													<option value='동구'>동구</option>
													<option value='서구'>서구</option>
													<option value='남구'>남구</option>												
												</select>
												</div>
					                        </div>
					                        <div class='col-md-4'>
					                        	<div class='form-group'>
													<select class="form-control" name="addr3" id="addr3">
													<option value="" selected='selected'>동</option>
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
					                            <label>Woman</label><input type="radio" name="gender" value="W">
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
													<input type="submit" value="Sign Up++" class="btn btn-primary">
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
  <script src="/js/main.js"></script>
    
  </body>
</html>