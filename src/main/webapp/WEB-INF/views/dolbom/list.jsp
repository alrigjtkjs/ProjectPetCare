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
    
    <style>
	.list_title h3 {
    display: block;
    color: #f24c59;
    font-size: 20px;
    padding-bottom: 10px;
    font-weight: 700;
    margin-top: 10px;
    }
    .list_title{
    width: 100%;
    position: relative;
    	padding: 10px 0;
    	clear: both;
    }
    .category {
    padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
	}
	.btn{
	padding:5px 10px;
	}
    </style>   
  </head>
<body>
<%@include file="../header.jsp" %>
    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    		<div class="list_title">
   				<h3>돌봄 리스트</h3>
   			</div>
            <table class="table table-hover">
               	<thead class="thead-dark">
	               	<tr>
	               		<th>요청자</th>
	               		<th>돌보미</th>
	               		<th>돌봄시간</th>
	               		<th>돌봄유형</th>
	               		<th>상태</th>
	               		<th>확인</th>
	               		<th>채팅</th>               		
	               		<th>삭제</th>
	               	</tr>
               	</thead>
               	<tbody id="dolbomTbody">
	            </tbody>
	        </table>
        </div>
    </section>
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
  <script>
  
 /*function resetReceive(){
	  $.ajax({
		  url: "../dolbom/rlist.json",
		  type: "POST",
		  success: function(data){
			  var html = "";
			  for(var i=0;i<data.length;i++){
				  html += '<tr>';
				  html += '<td><span class="category"><strong>돌봄'+data[i].category+'</strong></span></td>';
				  html += '<td>'+data[i].sendernick+'</td>';
				  html += '<td>'+data[i].workdate+'('+data[i].workday+') '+data[i].workstime+'~'+data[i].worketime+'</td>';
				  html += '<td>'+data[i].kind+'</td>'; 
				  html += '<td>'+data[i].message+'</td>';
				  html += '<td>'+data[i].state+'</td>';
				  if(data[i].state == "대기중"){
				  html += '<td><button type="submit" class="btn btn-danger btn-sm" id="yes" onclick="acceptList('+data[i].seq+')">수락</button>';
				  html += '<button type="submit" class="btn btn-secondary btn-sm" id="no" onclick="deleteList('+data[i].seq+')">거절</button>';
				  }else if(data[i].state == "진행중"){
					  if(data[i].category == "제공"){
						  html += '<td><button type="submit" class="btn btn-info btn-lg" id="finishid1" onclick="finishList('+data[i].seq+',this.id)" style="background-color:#F34A4A;">완료</button>';
						  }
				}else if(data[i].state == "완료"){
					if(data[i].category == "제공"){
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">후기작성</button>';
					}else{
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">완료</button>';
					}
				}
				  html += '</td>';
				  html += '</tr>';
			  }
			  $("#receiveTbody").html(html);
		  }	  
	  });
	  
  }
  function resetSend(){
	  $.ajax({
		  url: "../dolbom/slist.json",
		  type: "POST",
		  success: function(data){
			  var html = "";
			  for(var i=0;i<data.length;i++){
				  html += '<tr>';
				  html += '<td><span class="category"><strong>돌봄'+data[i].category+'</strong></span></td>';
				  html += '<td>'+data[i].receivernick+'</td>';
				  html += '<td>'+data[i].workdate+'('+data[i].workday+') '+data[i].workstime+'~'+data[i].worketime+'</td>';
				  html += '<td>'+data[i].kind+'</td>'; 
				  html += '<td>'+data[i].message+'</td>';
				  html += '<td>'+data[i].state+'</td>';
				  if(data[i].state == "대기중"){
				  html += '<td><button type="submit" class="btn btn-secondary btn-sm">수락대기중</button>';
				  }else if(data[i].state == "진행중"){
					  if(data[i].category == "요청"){
						  html += '<td><button type="submit" class="btn btn-info btn-lg" id="finishid2" onclick="finishList('+data[i].seq+',this.id)" style="background-color:#F34A4A;">완료</button>';
						  }
					  else{
						  html += '<td><button type="submit" class="btn btn-secondary btn-sm">진행중</button>';
					  }
				}else if(data[i].state == "완료"){
					if(data[i].category == "요청"){
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">후기작성</button>';
					}else{
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">완료</button>';
					}
				}
				  html += '</td>';
				  html += '</tr>';
			  }
			  $("#sendTbody").html(html);
		  }
		  
	  });
	  
  }*/
  function resetDList(){
	  $.ajax({
		  url: "../dolbom/dlist.json",
		  type: "POST",
		  success: function(data){
			  console.log(data);
			  var html = "";
			  for(var i=0;i<data.length;i++){
				  if(data[i].category=='요청'){
					  var receiver = data[i].sendernick
					  var dolbomy = data[i].receivernick
				  }else{
					  var receiver = data[i].receivernick
					  var dolbomy = data[i].sendernick					  
				  }
				  html += '<tr>';				  
				  html += '<td>'+receiver+'</td>';
				  html += '<td>'+dolbomy+'</td>';
				  html += '<td>'+data[i].workdate+'</td>';
				  html += '<td>'+data[i].kind+'</td>'; 
				  html += '<td>'+data[i].state+'</td>';
				  
				  if(data[i].state == "대기중"){
				  html += '<td><button type="submit" class="btn btn-secondary btn-sm">수락대기중</button>';
				  }else if(data[i].state == "진행중"){
					  if(data[i].category == "요청"){
						  html += '<td><button type="submit" class="btn btn-info btn-lg" id="finishid2" onclick="finishList('+data[i].seq+',this.id)" style="background-color:#F34A4A;">완료</button>';
						  }
					  else{
						  html += '<td><button type="submit" class="btn btn-secondary btn-sm">진행중</button>';
					  }
				}else if(data[i].state == "완료"){
					if(data[i].category == "요청"){
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">후기작성</button>';
					}else{
						html += '<td><button type="submit" class="btn btn-info btn-lg" style="background-color:#0D539D;">완료</button>';
					}
				}				  
				  html += '</td>';
				  html += '<td>'+'채팅'+'</td>';
				  html += '<td>'+'삭제'+'</td>';
				  html += '</tr>';
			  }
			  $("#dolbomTbody").html(html);
		  }
		  
	  });
	  
  }
  $(document).ready(function(){
	  //resetReceive();
	  //resetSend();
	  resetDList();
  });
 
	function acceptList(seq){
		console.log(seq);
		$.ajax({
	    	url: "../dolbom/acceptList.json",
			type: "GET",
			data: {seq:seq},
			success: function(data){
				alert("수락할까요?");
				resetReceive();		
			}
		});

	}
	function deleteList(seq){
		console.log(seq);
		$.ajax({
	    	url: "../dolbom/deleteList.json",
			type: "GET",
			data: {seq:seq},
			success: function(data){
				alert("거절할까요?/거절사유");
				resetReceive();		
			}
		});
	}
	function finishList(seq,id){
		console.log(seq,id);
		$.ajax({
	    	url: "../dolbom/finishList.json",
			type: "GET",
			data: {seq:seq},
			success: function(data){
				alert("돌봄을 완료할까요?");
				resetReceive();
				resetSend();
				
			}
		});
	}
	function cancelList(seq){
		console.log(seq);
		$.ajax({
	    	url: "../dolbom/cancelList.json",
			type: "GET",
			data: {seq:seq},
			success: function(data){
				alert("진행을 취소할까요?/취소사유");
				document.getElementById("continetab").click();	
			}
		});
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