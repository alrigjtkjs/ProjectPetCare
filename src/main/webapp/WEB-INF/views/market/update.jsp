<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
    	var selectedImages = [];
    	var savedImages = [];
    	var imgNum = 0;
    	
    	$(function(){
    		$("#category").val("${contents.category}").prop("selected",true);
    		$("#title").val("${contents.title}");
    		$("#content").val("${contents.content}");
    		
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
    		alert("update");
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
			
			formData.append("sm_seq", "${contents.sm_seq}");
			formData.append("category", $("#category").val());
			formData.append("title", $("#title").val());
			formData.append("content", $("#content").val());
			
			 for (var pair of formData.entries()) {
	             console.log(pair[0]+ ', ' + pair[1]); 
	         }
			 
			// 나중에 로그인한 멤버 email 추가
			$.ajax({
				type : "POST",
				url : "/market/update.json",
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					if(data){
						location.href="/market";
					}else{
						alert("실패");
					}
				}
			});
    	}
    </script>
    <style>
    	select{
    		text-align:center;
    		padding:0rem !important;
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
          	<p class="breadcrumbs mb-2"><span>Market<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">나눔 마켓</h1>
          </div>
        </div>
      </div>
    </section>
    <section class="ftco-section bg-light">
	    <div class="container">
		<!-- share market write -->
			<label for="select" class="form-label m-0">카테고리 / 제목</label>
			<div class="input-group mb-3">
				<select id="category" class="col-2 form-select" aria-label="Default select example">
					<option value="식품">식품</option>
					<option value="의류">의류</option>
					<option value="장난감">장난감</option>
				</select>
				<input id="title" type="text" class="form-control" aria-label="Text input with dropdown button">
			</div>
			<label for="fildDiv" class="form-label m-0">파일 첨부</label>
			<input type="button" class="btn btn-light p-0 mb-1" value="➕" onClick="uploadClick();" />
			<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
			<div class="row-cols-4 card-body mb-3 border rounded bg-white" id="imageList">
			</div>
			<div class="mb-3">
				<label for="content" class="form-label m-0">내용</label>
				<textarea class="form-control" id="content" rows="3"></textarea>
			</div>
			<div class="col-12 mb-3 text-center">
				<input type="button" class="btn btn-danger" value="취소"/>
				<input type="button" class="btn btn-primary" value="수정" onClick="update();"/>
			</div>
		<!-- share market write-->
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