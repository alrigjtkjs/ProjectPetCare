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
    	<h3><span>게시물 수정</span></h3>
    	<input type="hidden" id="g_seq" value="${galleryMyList.g_seq}">
		<label for="fildDiv" class="form-label m-0">파일 첨부</label>
		<button type="button" class="btn btn-outline-primary btn-sm" onClick="uploadClick();">
			<i class="fa fa-file-image-o" aria-hidden="true"></i>
		</button>
		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
		<div class="row-cols-4 card-body mb-3 border rounded bg-white" id="imageList"></div>
		<div class="mb-3">
			<label for="content" class="form-label m-0">내용</label>
			<textarea class="form-control" id="content" rows="15">${galleryMyList.content}</textarea>
		</div>
		<div class="col-12 mb-3 text-center">
			<input type="button" class="btn btn-danger" value="취소">
			<input type="button" class="btn btn-primary" value="수정" onclick="update();">
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
<script src="/js/main.js"></script>
<script>
	var selectedImages = [];
	var savedImages = [];
	var imgNum = 0;
	
	$(function(){
		$("#content").val("${galleryMyList.content}");
		
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
			var images = e.target.files;
			imageArr = Array.prototype.slice.call(images);
			
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

	function uploadClick(){
			$("#upload").click();
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
	function update(){
		alert("업데이트");
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
			}else{
				formData.append("fnames[0]", null);
			}
		}
		
		formData.append("g_seq", "${galleryMyList.g_seq}");
		formData.append("content", $("#content").val());
		
		 for (var pair of formData.entries()) {
           console.log(pair[0]+ ', ' + pair[1]); 
       }
		 
		// 나중에 로그인한 멤버 email 추가
		$.ajax({
			type : "POST",
			url : "/freeboard/galleryUpdate.json",	
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				if(data){
					location.href="/freeboard/galleryMyList";
				}else{
					alert("실패");
				}
			}
		});
	}
</script>
  
</body>
</html>