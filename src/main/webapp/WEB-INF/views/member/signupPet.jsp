<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Sign Up Pet</title>
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
	    var selectedImages = [];
		var imgNum = 0;
    	$(function(){
    		$('#petname').focus();
    		$("#petphoto").on("change", function(e){
    			$("#imageList").empty();
    			var images = e.target.files;
    			imageArr = Array.prototype.slice.call(images);
    			preview(imageArr);
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
    	
	    const email = "${sessionScope.email}";
	    function submit(){
	    	var formData = new FormData();
	    	
	    	for(var i=0; i<selectedImages.length; i++){
	    		if(selectedImages[i] != undefined){
	    			formData.append("multipartFiles", selectedImages[i]);
	    		}
	    	}
	    	var bdate = null;
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
			formData.append("email", email);
	    	formData.append("name", $('#petname').val());
	    	formData.append("kind", $('#petkind').val());
	    	formData.append("breed", $('#petbreed').val());
	    	formData.append("bdate", bdate);
	    	formData.append("sex", $("input[name='petxxx']:checked").val());
	    	formData.append("cut", $("input[name='petcut']:checked").val());
	    	formData.append("big", $("input[name='petbig']:checked").val());
	    	formData.append("memo", $('#memo').val());
	    	
	    	$.ajax({
				type : 'POST',
				url : "/member/signupPet.do",
				data : formData,
				processData : false,
				contentType: false,
				success : function(data){
					console.log("data"+data);
					if(data){
						alert('등록 되었습니다.');
						location.href="/member/mypage.do?email=${sessionScope.email}";
					}else{
						alert("등록 에러")
					}
				}
			});	    	
	    }
    </script>
    <style>
    	textarea{
    		resize: none;
    	}
    </style>
  </head>
  <body>
	<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Signup Pet<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">반려동물 등록</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#Sign Up Pet</h2>
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
								<h3 class="mb-4">반려동물 정보입력</h3>								
								<div class="row">
									<div class="col-md-6"></div>	
                     					<div class="col-md-12">
										<div class="form-group">
											<label class="label" for="name">NAME</label>
											 <div class="input-group">
												<input type="text" class="form-control" name="petname" id="petname" placeholder="이름">
											</div>
											<label class="label" for="big">PHOTO</label>
											<input type="file" class="form-control" id="petphoto" multiple accept="">
											<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
										</div>
                    					 </div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="bdate">BIRTHDAY</label>
											<select class="form-control" name="byear" id="byear" >
												<option value="" selected='selected'>연도</option>
												<c:forEach begin='1990' end='2022' step='1' var='i'>
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
									<div class="col-md-6">
										<div class="form-group">
											<label class="label" for="kind">KIND</label>
											<select class="form-control" name="petkind" id="petkind">
												<option value="" selected='selected'>분류</option>
												<option value="개">개</option>
												<option value="고양이">고양이</option>
												<option value="새">새</option>
												<option value="기타">기타</option>
											</select>
										</div>
                    					 </div>
				                      <div class="col-md-6">
										<div class="form-group">
											<label class="label" for="breed">BREED</label>
											<input type="text" class="form-control" name="petbreed" id="petbreed" placeholder="품종">
										</div>
                    					 </div>
                    					 <div class="col-md-4">
                       					<div class="form-group">                        						
											<label class="label" for="sex">성별</label>&nbsp;&nbsp;&nbsp;&nbsp;
											<label>Male</label><input type="radio" name="petxxx" value="M">&nbsp;&nbsp;
				                            <label>Female</label><input type="radio" name="petxxx" value="F">
										</div>
                     					</div>
                     					<div class="col-md-4">
                       					<div class="form-group">                        						
											<label class="label" for="cut">중성화 하셨나요?</label>&nbsp;&nbsp;&nbsp;&nbsp;
											<label>Yes:)</label><input type="radio" name="petcut" value="Y">&nbsp;&nbsp;
				                            <label>Nope:(</label><input type="radio" name="petcut" value="N">
										</div>
                     					</div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="big">SIZE</label>&nbsp;&nbsp;&nbsp;&nbsp;
											<label>SMALL</label><input type="radio" name="petbig" value="S">&nbsp;&nbsp;
				                            <label>MEDIUM</label><input type="radio" name="petbig" value="M">&nbsp;&nbsp;
				                            <label>LARGE</label><input type="radio" name="petbig" value="L">
										</div>
                     					</div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="big">MEMO</label>
											<span id="length-check"><small>최대 200자까지</small></span>
											<textarea rows="6" cols="65" id="memo" name="memo" placeholder="메모" maxlength="200"></textarea>
										</div>
                     					</div>
                     					<div class="col-md-12">
										<div class="form-group">												
											<input onClick="submit();" type="button" value="Sign Up" class="btn btn-primary">
											<input type="reset" value="다시 쓰기" class="btn btn-primary" />
										</div>
									</div>                      					
								</div>								
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