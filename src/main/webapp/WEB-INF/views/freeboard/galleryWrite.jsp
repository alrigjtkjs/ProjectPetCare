<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
select{
	text-align:center;
	padding:0rem !important;
}
.files{
	height:3rem;
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
          	<p class="breadcrumbs mb-2"><span>Free Board<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">자유 게시판</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    	<h3><span>게시물 작성</span></h3>
    	<input type="hidden" id="g_seq" value="${galleryList.g_seq}">
		<div class="row row-md-12 mb-3">
			<div class="col-12 col-md-12 input-group p-0">
				<label for="fileDiv" class="form-label m-0">파일 등록</label>
				<button type="button" class="btn btn-outline-primary btn-sm" onClick="uploadClick();"><i class="fa fa-file-image-o" aria-hidden="true"></i></button>
				<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
			</div>
			<div class="col-12 col-md-12">
				<div class="row row-md-12 border rounded bg-white" id="imageList"></div>
			</div>
		</div>
		<div class="row row-md-12 mb-3">
			<label for="content" class="col-12 col-md-12 form-label m-0 p-0">내용</label>
			<textarea class="col-12 col-md-12 form-control" id="content" rows="15"></textarea>
		</div>
		<div class="col-12 col-md-12 mb-3 text-center">
			<input type="button" class="btn btn-danger" value="취소"/>
			<input type="button" class="btn btn-primary" value="등록" onClick="submit();"/>
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
<script src="/js/jquery.stellar.min.js"></script>
<script src="/js/jquery.animateNumber.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/jquery.timepicker.min.js"></script>
<script src="/js/owl.carousel.min.js"></script>
<script src="/js/jquery.magnific-popup.min.js"></script>
<script src="/js/scrollax.min.js"></script>
<script src="/js/main.js"></script>
<script>
  //이미지 업로드
	var selectedImages = [];
	var imgNum = 0;
	
	$(function(){
		$("#upload").on("change", function(e){
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
					html += "<div class='col-3 col-md-3 align-self-center' onclick='deleteClick(this,"+imgNum+");'>";
					html += "<img src='"+e.target.result+"' title='"+i.name+"' class='img-fluid'>";
					html += "</div>"
					$("#imageList").html(html);
					imgNum ++;
				}
				reader.readAsDataURL(i);
			}else{
				
			}
		});
		$("#upload").val("");
	}
	function uploadClick(){
		$("#upload").click();
}
	function deleteClick(imgObj, i){
		selectedImages.splice(i, 1);
		console.log(selectedImages[0]);
		console.log(selectedImages[1]);
		console.log(selectedImages[2]);
		console.log(selectedImages[3]);
		console.log(imgObj);
		$(imgObj).remove();
	}
	function submit(){
	var formData = new FormData();
	
	for(var i=0; i<selectedImages.length; i++){
		if(selectedImages[i] != undefined){
			formData.append("multipartFiles", selectedImages[i]);
			console.log(formData);
		}
	}
	formData.append("content", $("#content").val());
	// 나중에 로그인한 멤버 email 추가
	$.ajax({
		type : "POST",
		url : "/freeboard/galleryWrite.json",
		data : formData,
		processData : false,
		contentType : false,
		success : function(data){
			if(data){
				location.href="/freeboard/galleryList";
			}else{
				alert("안들어감");
			}
		}
	});
	//사진파일이 없을때 alret
 	/*var fileCheck = document.getElementById("upload").value;
	     if(!fileCheck){
	        alert("이미지가 없습니다. 이미지 파일을 첨부해 주세요.");
	 	}
	    return false;*/
}
</script>
</body>
</html>