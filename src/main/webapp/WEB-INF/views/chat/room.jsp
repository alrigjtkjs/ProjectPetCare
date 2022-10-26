<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Room</title>
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
		.roomContainer{
			background-color: #F6F6F6;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.roomList{
			border: none;
		}
		.roomList th{
			border: 1px solid #FFBB00;
			background-color: #fff;
			color: #FFBB00;
		}
		.roomList td{
			border: 1px solid #FFBB00;
			background-color: #fff;
			text-align: left;
			color: #FFBB00;
		}
		.roomList .num{
			width: 75px;
			text-align: center;
		}
		.roomList .room{
			width: 350px;
		}
		.roomList .go{
			width: 71px;
			text-align: center;
		}
		button{
			background-color: #FFBB00;
			font-size: 14px;
			color: #000;
			border: 1px solid #000;
			border-radius: 5px;
			padding: 3px;
			margin: 3px;
		}
		.inputTable th{
			padding: 5px;
		}
		.inputTable input{
			width: 330px;
			height: 25px;
		}
		#Refreshbtn{
			float:right;
		}
	</style>
</head>

<script>
	var ws;
	var userName;
	window.onload = function(){
		getRoom();
		createRoom();
	}

	function getRoom(){
		var msg = {email:"${sessionScope.email}"};
		commonAjax('/getRoom.json', msg, 'post', function(result){
			createChatingRoom(result);
		});
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
			},
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	function createRoom(){
		$("#createRoom").click(function(){
			var msg = {	roomName : userName, email:"${sessionScope.email}"};
			console.log("createRoom");
			commonAjax('/createRoom.json', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}

	function goRoom(number, name){
		location.href="/moveChating?roomName="+name+"&"+"roomNumber="+number;
	}

	function createChatingRoom(res){
		if(res != null){
			var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='num'>룸넘버</th><th class='go'></th></tr>";
			console.log("채팅방 만들기");
			console.log(res);
			res.forEach(function(d, idx){
				if(d.c_subject==null){
						
				}else{
				var rn = d.c_subject.trim();
				var roomNumber = d.c_number;
				tag += "<tr>"+
							"<td class='num'>"+(idx+1)+"</td>"+
							"<td class='room'>"+ rn +"</td>"+
							"<td class='num'>"+roomNumber+"</td>"+
							"<td class='go'><button type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>" +
						"</tr>";
				}
			});
			$("#roomList").empty().append(tag);
		}
	}
	function searchRoom(){
		var searchRoomName = $("#search").val();
		$.ajax({
			url: "/searchroom.json",
			data: {"c_owner":"${sessionScope.email}", "c_guest":"aa@example.com", "c_subject":searchRoomName},
			type: "POST",
			success: function(data){
				createChatingRoom(data);
			}
		});
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				console.log(res);
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
</script>
<body>
	<div class="container">
		<h1>채팅방</h1>
		<button id="rollback" onclick="location.href='../'">뒤로가기</button>
		<button id="Refreshbtn" onclick="getRoom()">새로고침</button>
		<div id="roomContainer" class="roomContainer">
			<table id="roomList" class="roomList"></table>
		</div>
		<div>
			<table class="inputTable">
				<tr>
					<th><button id="createRoom">방 만들기</button></th>
				</tr>
				<tr>
					<th><input id="search" placeholder="방 이름을 검색해주세요"></th>
					<th><button onclick="searchRoom()" id="sendBtn">검색</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>