<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
   <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  </head>
<body>
<%@include file="../header.jsp" %>

	<section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Pet Care Form form Receiver<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">돌보미 요청하기</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
			<div class="container">
				<div class="info">
					지원자 프로필
					지원자 프로필
					지원자 프로필
					지원자 프로필
				</div>
			<form class="receivef" name="receivef" action="re_write.do" method="post">
            <div class="table table-responsive">
               <h4>돌봄 요청 내용</h4>
               <table class="table table-striped table table-bordered">
		            <tr>
		               <td>돌봄 종류</td>
		               <td>
			               <input type="checkbox" name="kind" value="산책" onclick="tagChange(event)">산책&nbsp;
			               <input type="checkbox" name="kind" value="방문돌봄" onclick="tagChange(event)">방문돌봄&nbsp;
			               <input type="checkbox" name="kind" value="위탁돌봄" onclick="tagChange(event)">위탁돌봄
			           </td>
		            </tr>
            		<tr>
		               <td class="td-color">돌봄 날짜/시간</td>
		               <td>
		               	<input type="date" name="workdate" id="workdate"/>
		               	<select name="selectSTime" id="selectSTime">
		               		<option>오전</option>
		               		<option>오후</option>
		               	</select>
		               	<select name="timeSTable" id="timeSTable">
		               		<option>시간 선택</option>
		               		<option value="01:00">1:00</option>
		               		<option value="02:00">2:00</option>
		               		<option value="03:00">3:00</option>
		               		<option value="04:00">4:00</option>
		               		<option value="05:00">5:00</option>
		               		<option value="06:00">6:00</option>
		               		<option value="07:00">7:00</option>
		               		<option value="08:00">8:00</option>
		               		<option value="09:00">9:00</option>
		               		<option>10:00</option>
		               		<option>11:00</option>
		               		<option>12:00</option>
		               	</select>
		               	부터
		               	<select name="selectETime" id="selectETime">
		               		<option>오전</option>
		               		<option>오후</option>
		               	</select>
		               	<select name="timeETable" id="timeETable">
		               		<option>시간 선택</option>
		               		<option value="01:00">1:00</option>
		               		<option value="02:00">2:00</option>
		               		<option value="03:00">3:00</option>
		               		<option value="04:00">4:00</option>
		               		<option value="05:00">5:00</option>
		               		<option value="06:00">6:00</option>
		               		<option value="07:00">7:00</option>
		               		<option value="08:00">8:00</option>
		               		<option value="09:00">9:00</option>
		               		<option>10:00</option>
		               		<option>11:00</option>
		               		<option>12:00</option>
		               	</select>
               			까지
               	

		              </td>
		            </tr>
		            <tr>
		               <td>돌봄 지역</td>
		               <td>
			               <input type="text" name="region" value="${region}" readonly>
		               		<p>* 돌봄 지역은 내가 설정한 동네의 이웃 동네 범위까지 가능해요</p>
			           </td>
		            </tr>    
		            <tr>
		               <td class="td-color">제목</td>
		               <td><input type="text"  class="form-control" name="title" placeholder="제목을 입력해 주세요"></td>
		            </tr>
		            
		            <tr>
		               <td class="td-color">상세 요청 내용</td>
		               <td><textarea rows="5" cols="50" name="content" class="form-control" placeholder="요청 내용을 상세히 작성해주세요"></textarea></td>
		            </tr>       
		       </table>
             	<br>
            	<h4>돌봄 이웃 선택</h4>
               <table class="table table-striped table table-bordered">
		            <tr>
		               <td>성별</td>
		               <td>
			               <label for="gender1"><input type="radio" name="gender" id="gender1" value="남성" onclick="tagChange(event)">남성</label>&nbsp;
			               <label for="gender2"><input type="radio" name="gender" id="gender2" value="여성" onclick="tagChange(event)">여성</label>&nbsp;
			               <label for="gender3"><input type="radio" name="gender" id="gender3" value="남/여" onclick="tagChange(event)">상관없음</label>
			           </td>
		            </tr>
		            <tr>
		               <td>희망이웃</td>
		               <td>
			               <label for="neighbor1"><input type="radio" name="neighbor" id="neighbor1" value="견주" onclick="tagChange(event)">견주</label>&nbsp;
			               <label for="neighbor2"><input type="radio" name="neighbor" id="neighbor2" value="집사" onclick="tagChange(event)">집사</label>&nbsp;
			               <label for="neighbor3"><input type="radio" name="neighbor" id="neighbor3" value="견주/집사" onclick="tagChange(event)">견주/집사</label>
			           </td>
		            </tr>
		            <tr>
		               <td>사전만남</td>
		               <td>
			               <label for="meeting1"><input type="radio" name="meeting" id="meeting1" value="사전만남" onclick="tagChange(event)">사전만남 원해요</label>&nbsp;
			               <label for="meeting2"><input type="radio" name="meeting" id="meeting2" value="X" onclick="tagChange(event)">사전만남 없어도 돼요</label>
			           </td>
		            </tr>
		            <tr>
		               <td>키워드</td>
		               <td>
			               <div id="tags" name="tags"></div>
			           </td>
		            </tr>
            	</table>
            
	            <div class="pet-info">
			            반려동물 정보<br>
			            반려동물 정보<br>
			            반려동물 정보<br>
			            반려동물 정보<br>
			            반려동물 정보<br>
	            </div>
	            <div class="agree">
	            	<input type="checkbox" id="agreement" name="agreement"/>&nbsp;아래 내용에 확인 및 동의합니다.<br>
	            	<div style="border:solid 1px gray;">
	            	 - 돌보미를 무는 등의 심한 공격성을 보이거나, 파보/피부염/기관지염 등 전염성 질병의 경우, 등록하신 반려동물 프로필이 실제와 다른 경우 돌봄이 불가할 수 있습니다.<br>
	            	 - 사실과 다른 반려동물 프로필 기재로 문제가 발생한 경우, 책임은 보호자님께 있음에 동의합니다.<br>
	            	 - 동물보호법 제12조/동물보호법 시행규칙 제11조 [시행 2020.3.21]에 따라 인식표를 지참하지 않으면 야외 산책이 어려울 수 있으니, 꼭 인식표를 지참해 주세요.<br>
	            	</div>
	            </div>
	            <div class="write-btn" align="center">
	               <button type="button" class="btn btn-outline-info btn-lg" id="listButton" onclick="location.href='/dolbom/list.do'">목록</button>	
	               <button type="button" class="btn btn-info btn-lg" id="saveButton" onclick="check()">등록</button>	
	            </div>
            </div>
         	</form>
		</div>
	</section>
        
    <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

	<script>	
		 function tagChange(e){
			 var checkboxValues = [];
			    $("input[name='kind']:checked").each(function(i) {
			        checkboxValues.push($(this).val());
			    });
			 if(checkboxValues==''){
				 console.log("비었음");
				 checkboxValues = [''];
			 }
			 var gender = $("input[name='gender']:checked").val();
			 var neighbor = $("input[name='neighbor']:checked").val();
			 var meeting = $("input[name='meeting']:checked").val();			 
			 console.log(checkboxValues);
			 console.log(gender);
			 console.log(neighbor);
			 console.log(meeting);
			    
			 $.ajax({
				 url: "../dolbom/receiver_tagitems.json",
				 type: "GET",
				 data: {checkboxValues:checkboxValues,gender:gender,neighbor:neighbor,meeting:meeting		 
				 },
				 success: function(data){
					 alert("성공");
					 var html = "";
					 if(data.kind.length != 0){
					 html += "#"+data.kind+" ";
					 }
					 if(data.gender != null){
					 html += "#"+data.gender+" ";
					 }
					 if(data.neighbor != null){
					 html += "#"+data.neighbor+" ";
					 }
					 if(data.meeting != null && data.meeting != "X"){
					 html += "#"+data.meeting;
					 }
					 
					 $("#tags").html(html);
				 }
			 });
		 }
		 function check(){
			 var redate = document.querySelector("#workdate").value;
			 if(redate==""){
				 alert("날짜를 입력해주세요.");
			 }else{
				 document.receivef.submit();
			 }
		 }

  </script>

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