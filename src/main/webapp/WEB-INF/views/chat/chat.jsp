<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Chating</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			color: black;
			text-align: right;
		}
		.chating .others{
			color: black;
			text-align: left;
		}
		input{
			width: 330px;
			height: 25px;
		}
		#yourMsg{
			display: ;
		}
		.mymsg{
			background-color: white;
			border-radius: 5px;
		}
		.othersmsg{
			background-color: #d3dbe3;
			border-radius: 5px;
		}
		.otherName{
			background-color: #d3dbe3;
			border-radius: 5px;
		}
		
	</style>
</head>

<script type="text/javascript">
	var ws;
	var userName;

	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		console.log("소켓 열림");
		wsEvt();
	}
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
			console.log("소켓이 열리면 동작");
			console.log(userName);
			var option ={
					type: "enterEvent",
					roomNumber: $("#roomNumber").val(),
					sessionId : $("sessionId").val(),
					userName : userName,
					msg : "님이 입장하셨습니다"
				}
			ws.send(JSON.stringify(option));
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.sessionId == $("#sessionId").val()){
						console.log(d.sessionId);
						if(d.msg == ""){
							
						}else{$("#chating").append("<p class='me'><span class='mymsg'>" + d.msg + "</span></p><br>");
						}
					}else{
						if(d.msg == ""){
							
						}else{
							$("#chating").append("<p class='others'><span class='otherName'>" + d.userName + "</span><br><span class='othersmsg'>" + d.msg + "</span></p><br>");
						}
					}					
				}else if(d.type == "wsClose"){
					alert("방장이 채팅방을 폭파시켰습니다");
					ws.close();
					location.href="../room";
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
		
		ws.onclose = function(data){
			alert("진짜 종료됨");
			location.href="../room";
		}
	}
	
	$(document).ready(function(){
			var email = "${sessionScope.email}";	
			$.ajax({
				url:"/getNickName.json",
				type: "POST",
				data: {"email": email},
				success: function(data){
					console.log("성공");
					console.log(data.userName);
					userName = data.userName;
					wsOpen();
					console.log("시작메소드");
					console.log(userName);
					$("#yourName").hide();
					$("#yourMsg").show();
				},
				error: function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
	});
	

	function send() {
		var option ={
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : userName,
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
	function wsClose(){
		alert("채팅방 연결종료!");
		$.ajax({
			url:"/deleteRoom.json",
			type: "POST",
			data: {"roomNumber": $("#roomNumber").val(), "roomName":"${roomName}", "email":"${sessionScope.email}"},
			success: function(data){
				
			}

		});
		var option ={
				type: "wsClose",
				roomNumber: $("#roomNumber").val(),
				sessionId : $("#sessionId").val(),
				userName : userName,
				msg : "채팅방 연결종료"
			}
		ws.send(JSON.stringify(option));
		ws.close();
	}
	
	
	
</script>
<body>
	<div id="container" class="container">
		<h1>${roomName}의 채팅방</h1>
		<button onclick="location.href='../room'">채팅방 메인으로</button>
		<button onclick="wsClose()">채팅방 닫기</button>
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
		
		<div id="chating" class="chating">
		
		<c:forEach items="${recordslist}" var="records">
		<c:choose>
		<c:when test="${records.userName == uN}">
		<p class='me'>
		<span class='mymsg'>${records.msg}</span>
		</p>
		<br>
		</c:when>
		<c:otherwise>
		<p class='others'>
		<span class='otherName'>${records.userName}</span>
		<br>
		<span class='othersmsg'>${records.msg}</span>
		</p>
		<br>
		</c:otherwise>
		</c:choose>
		</c:forEach>		
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>