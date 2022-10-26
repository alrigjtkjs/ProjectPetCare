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
		var savedImages = [];
		var imgNum = 0;
		
    	$(function(){
    		$("#petname").val("${petone.name}");
    		$("#petkind").val("${petone.kind}");
    		$("#petbreed").val("${petone.breed}");
    		$("#petxxx").val("${petone.sex}");
    		$("#petcut").val("${petone.cut}");
    		$("#petbig").val("${petone.big}");
    		$("#memo").val("${petone.memo}");
    		
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
	    
	    function submit(){
	    	var formData = new FormData();
	    	
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
	        var formdata = 
				{
					"name":  $('#petname').val(),
					"breed": $('#petbreed').val(),			
					"bdate": bdate,
					"cut": $('#petcut').val(),
					"big": $('#petbig').val(),
					"memo": $('#memo').val(),
					"petseq": "${petone.petseq}"
				};
	    	$.ajax({
				type : 'POST',
				url : "/member/updateP.do",
				data : JSON.stringify(formdata),
				contentType: "application/json; charset=UTF-8",
				success : function(data){
					if(data){
						alert('수정 되었습니다.');
						location.href="/member/mypage.do?email=${sessionScope.email}";
					}else{
						alert("수정 에러")
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
          	<p class="breadcrumbs mb-2"><span>update Pet<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">반려동물 정보수정</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<div class="row justify-content-center">
			<div class="col-md-6 text-center mb-5">
				<h2 class="heading-section">#Update Pet</h2>
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
								<h3 class="mb-4">반려동물 정보수정</h3>								
								<div class="row">
									<div class="col-md-6"></div>								
                     					<div class="col-md-12">
										<div class="form-group">
											<label class="label" for="name">NAME</label>
											 <div class="input-group">
												<input type="text" class="form-control" id="petname">
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
											<input type="text" class="form-control" id="petkind" disabled>
										</div>
                    					 </div>
				                      <div class="col-md-6">
										<div class="form-group">
											<label class="label" for="breed">BREED</label>
											<input type="text" class="form-control" id="petbreed">
										</div>
                    					 </div>
                    					 <div class="col-md-4">
                       					<div class="form-group">                        						
											<label class="label" for="sex">성별</label>
											<input type="text" class="form-control" id="petxxx" disabled>
										</div>
                     					</div>
                     					<div class="col-md-4">
                       					<div class="form-group">                        						
											<label class="label" for="cut">중성화 하셨나요?</label>
											<input type="text" class="form-control" id="petcut">
										</div>
                     					</div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="big">SIZE</label>
											<input type="text" class="form-control" id="petbig">
										</div>
                     					</div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="big">MEMO</label>
											<span id="length-check"><small>최대 200자까지</small></span>
											<textarea rows="6" cols="65" id="memo" maxlength="200"></textarea>
										</div>
                     					</div>
                     					<div class="col-md-12">
										<div class="form-group">										
											<input onClick="submit();" type="button" value="Update" class="btn btn-primary">
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