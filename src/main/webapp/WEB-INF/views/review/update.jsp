<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../header.jsp" %>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
	</script>
	<!-- Bootstrap CSS -->
	<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous"> -->
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
	$(document).on('click', '#btnSave', function(e) {
		e.preventDefault();
		if($('#star').val() < 0 || $('#star').val() > 5 ){			
			alert("별점평가는 0~5점까지 가능합니다!"); 
			$('#star').focus();		
		}else {
			$("#form").submit();			
		}
	});

	$(document).on(	
					'click',
					'#btnList',
					function(e) {
						e.preventDefault();
						location.href = "${pageContext.request.contextPath}/board/getBoardList";// -> review/list 로 수정 시  목록 list로 띄움
					});
</script>

<style>

.star-input{
	padding: 25px 15px;
}

.star-input>.input{
text-align: center;
    margin-top: 10px;
}

.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('../images/grade_img.png')no-repeat;}
.star-input {
    width: 100%;
    text-align: center;
}

.score{font-size:18px; line-height:25px; #fc4c4e; font-weight:bold; text-align:center;}
/* .star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;} */
.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position:relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}
.star-input>.input>label[for="p1_2"]{width:15px;z-index:10;}
.star-input>.input>label[for="p1"]{width:30px;z-index:9;}
.star-input>.input>label[for="p2_2"]{width:45px;z-index:8;}
.star-input>.input>label[for="p2"]{width:60px;z-index:7;}
.star-input>.input>label[for="p3_2"]{width:75px;z-index:6;}
.star-input>.input>label[for="p3"]{width:90px;z-index:5;}
.star-input>.input>label[for="p4_2"]{width:105px;z-index:4;}
.star-input>.input>label[for="p4"]{width:120px;z-index:3;}
.star-input>.input>label[for="p5_2"]{width:135px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}
</style>
</head>

<body>
	<article>
		<div class="container" role="main">
			<h2>이용후기</h2> 
			<form name="form" id="form" role="form" method="post" action="update.do">
				<!-- board/saveBoard 이렇게 되어 있었음 -->
				<div class="image-container">
					<img style="width: 1110px; height: 300px" id="preview-image"
						src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
					<input style="display: block;" type="file" id="input-image">
					<!-- 	<input type="file" id="input-imag" onchange="previewFile()" style="display: none;"></input> 
					 <label for="imgUpload">이미지 추가</label> //파일선택이라는 문수 이미지 추가로 바뀌는 로직이지만 버튼은 구현되지만 기능이 구현이 안됨-->
					<script>
					function setDetailImage(event){
						for(var image of event.target.files){
							var reader = new FileReader();
							
							reader.onload = function(event){
								var img = document.createElement("img");
								img.setAttribute("src", event.target.result);
								img.setAttribute("class", "col-lg-6");
								document.querySelector("div#images_container").appendChild(img);
							};
							reader.readAsDataURL(image);
						}
					}
					function readImage(input) {
					    // 인풋 태그에 파일이 있는 경우
					    if(input.files && input.files[0]) {
					        // 이미지 파일인지 검사 (생략)
					        
					        // FileReader 인스턴스 생성
					        const reader = new FileReader()
					        // 이미지가 로드가 된 경우
					        reader.onload = e => {
					            const previewImage = document.getElementById("preview-image")
					            previewImage.src = e.target.result
					        }
					        // reader가 이미지 읽도록 하기
					        reader.readAsDataURL(input.files[0]){}

					// input file에 change 이벤트 부여
					const inputImage = document.getElementById("input-image")
					inputImage.addEventListener("change", e => {
					    readImage(e.target)
					})
					</script>
				</div>
								
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="10" name="content"
						id="content" style="resize: none" placeholder="내용을 입력해 주세요" >${carereview.content}</textarea>
				</div>

				<div class="star-input">
					<p class="score"><strong>별점평가</strong></p>
					<span class="input">
						<input type="radio" name="star" value="1" id="p1">
						<label for="p1">1</label>
						<input type="radio" name="star" value="0.5" id="p1_2">
						<label for="p1_2">0.5</label>
						<input type="radio" name="star" value="2" id="p2">
						<label for="p2">2</label>
						<input type="radio" name="star" value="1.5" id="p2_2">
						<label for="p2_2">1.5</label>
						<input type="radio" name="star" value="3" id="p3">
						<label for="p3">3</label>
						<input type="radio" name="star" value="2.5" id="p3_2">
						<label for="p3_2">2.5</label>
						<input type="radio" name="star" value="4" id="p4">
						<label for="p4">4</label>
						<input type="radio" name="star" value="3.5" id="p4_2">
						<label for="p4_2">3.5</label>
						<input type="radio" name="star" value="5" id="p5">
						<label for="p5">5</label>
						<input type="radio" name="star" value="4.5" id="p5_2">
						<label for="p5_2">4.5</label>
					</span>
				</div>
		
			<div>
				<button type="submit" class="btn btn-sm btn-primary" id="btnSave">수정하기</button><!-- 23번줄 btnSave로 summit기능 있음! -->
			</div>

				<input type="hidden" name="cr_seq" value="${carereview.cr_seq}">
			</form>
		</div>
	</article>
	<%@include file="../footer.jsp"%>
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
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>
</body>
</html>