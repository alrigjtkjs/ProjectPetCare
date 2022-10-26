<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  </head>
  <style>
   .employer_info{
 	width: 100%;
     position: relative;
   	border-bottom: 1px solid #ccc;
   	padding: 10px 0;
   	clear: both;
   	margin-top:20px;
    }
    .photo{
    padding-top: 10px;
    padding-left: 10px;
    width: 200px;
    height: 200px;
    float: left;
    margin-right: 10px;
    text-align: center;
    }
    .btn_wrap{
    text-align: right;
    position: relative;
    margin: 10px 0;
    top: 0;
    padding: 10px;
    right: 10px;
    bottom: 20px;
    }
    strong.title {
    display: block;
    color: #f24c59;
    font-size: 20px;
    padding-bottom: 10px;
    font-weight: 700;
    margin-top: 10px;
    }
    .employer_text{
    width: 100%;
    position: relative;
    border-bottom: 1px solid #ccc;
    padding: 10px 0;
    clear: both;
    }
    .petinfo{
    width: 100%;
    position: relative;
    border-bottom: 1px solid #ccc;
    padding: 10px 0;
    clear: both;
    }
    .comments{
    position: relative;
    padding: 10px 0;
    clear: both;
    }
    .petinfo .card {
    border-radius: 10px;
    margin: 10px;
	}

	.petinfo .card .card-header .profile_img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    margin: 10px auto;
    border: 5px solid #ccc;
    border-radius: 50%;
	}

	.petinfo .card h3 {
	 font-size: 20px;
	 font-weight: 700;
	}

	.petinfo .card p {
	 font-size: 16px;
	 color: #000;
	}
	.modal-bg {display:none;width:100%;height:100%;position:fixed;top:0;left:0;right:0;background: rgba(0, 0, 0, 0.6);z-index:999;}
	.modal-wrap {display:none;position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:500px;height:400px;background:#F7F8E0;z-index:1000;text-align:center;border-radius: 5%;}
	.modal-message{width:80%;margin:auto;}
	.modal-message .countText{text-align:right;}
  </style>
  <body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Pet Care<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">우리동네 돌보미</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    	<div class="row">
    		<div class="employer_info">
    			<strong class="title">등록 정보</strong>
    			<div class="photo">
    				프로필사진
    			</div>
    			<div class="info">
    				<div>
    					<h5>[돌봄 ${dolbom.category}]</h5>
    					<span class="kind"><strong>돌봄 종류&nbsp;</strong>${dolbom.kind}</span>
    				</div>
    				<div class="date">
	    				<span class="workdate"><strong>돌봄 시간&nbsp;</strong>${dolbom.header}</span>
	    				<c:if test="${dolbom.category eq '제공'}">
	    				<span class="worktime">( ${dolbom.workstime}~${dolbom.worketime} )</span>
	    				</c:if>
    				</div>
    				<div class="wdate"><strong>등록일&nbsp;</strong>${dolbom.wdate}</div>
    				<div>
    					<span class="writer">${dolbom.nickname}</span>
    					&nbsp;·&nbsp;
    					<span class="region">${dolbom.region}</span>	
    				</div>
    				<div><br>
    					<span class="chat">채팅1</span>
			    		<span class="views">조회수1</span>
			    		<span class="likes">좋아요1</span>
    				</div>
    			</div>
    			<div class="btn_wrap">	
    				<c:if test="${dolbom.category eq '요청'}">	
    				<button type="submit" class="btn btn-info btn-lg" id="help" onclick="check();" style="background-color:#F34A4A;">🙋‍♂️돕기</button>
	    			</c:if>
	    			<c:if test="${dolbom.category eq '제공'}">
	    			<button type="submit" class="btn btn-info btn-lg" id="help" onClick="check();" style="background-color:#F34A4A;">🙋‍♂️요청</button>
	    			</c:if>
	    			<button type="submit" class="btn btn-info btn-lg" id="profile">등록자 프로필</button>
	    			<button type="submit" class="btn btn-info btn-lg" id="chat" onClick="location.href='/room'">채팅</button>
	    			<button type="submit" class="btn btn-info btn-lg" id="declaration"style="background-color:gray;">🚨신고</button>
	    		</div>
    		</div>
			<div class="employer_text">
				<strong class="title">상세 내용</strong>
    			<div>${dolbom.content}</div>
    		</div>
    		<div class="petinfo">
    			<strong class="title">반려동물 정보</strong>
    			<div class="row">
    			<div class="col-md-3">
			        <div class="card shadow-sm">
			          <div class="card-header bg-transparent text-center">
			            <img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">
			            <h3>앙리</h3>
			          </div>
			          <div class="card-body">
			          	<p class="mb-0"><strong class="pr-1">분 류</strong>강아지</p>
			          	<p class="mb-0"><strong class="pr-1">품 종</strong>보더콜리</p>
			          	<p class="mb-0"><strong class="pr-1">크 기</strong>&nbsp;중형</p>
			            <p class="mb-0"><strong class="pr-1">나 이</strong>&nbsp;2살</p>
			            <p class="mb-0"><strong class="pr-1">중성화</strong>&nbsp;O</p>
			            <p class="mb-0">#사람을 좋아해요 #활발</p>  
			          </div>
			        </div>
		      	</div>
		      	<div class="col-md-3">
			        <div class="card shadow-sm">
			          <div class="card-header bg-transparent text-center">
			            <img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">
			            <h3>앙리</h3>
			          </div>
			          <div class="card-body">
			          	<p class="mb-0"><strong class="pr-1">분 류</strong>강아지</p>
			          	<p class="mb-0"><strong class="pr-1">품 종</strong>보더콜리</p>
			          	<p class="mb-0"><strong class="pr-1">크 기</strong>&nbsp;중형</p>
			            <p class="mb-0"><strong class="pr-1">나 이</strong>&nbsp;2살</p>
			            <p class="mb-0"><strong class="pr-1">중성화</strong>&nbsp;O</p>
			            <p class="mb-0">#사람을 좋아해요 #활발</p>  
			          </div>
			        </div>
		      	</div>
		      	</div>
		    </div>
    		<div class="comments">
    			<strong class="title">댓글(2)</strong>
    			<ul class="comment-list">
	    			<li class="comment">		
		    			<div class="vcard bio">
		    				<img src="images/person_1.jpg" alt="Image placeholder">
		                </div>
		                <div class="comment-body">
		                <h3>John Doe</h3>
		                    <div class="meta">April 7, 2020 at 10:05pm</div>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
		                    <p><a href="#" class="reply">Reply</a></p>
			            </div>
			            <ul class="children">
		                    <li class="comment">
		                      <div class="vcard bio">
		                        <img src="images/person_1.jpg" alt="Image placeholder">
		                      </div>
		                      <div class="comment-body">
		                        <h3>John Doe</h3>
		                        <div class="meta">April 7, 2020 at 10:05pm</div>
		                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem laborum necessitatibus, ipsam impedit vitae autem, eum officia, fugiat saepe enim sapiente iste iure! Quam voluptas earum impedit necessitatibus, nihil?</p>
		                        <p><a href="#" class="reply">Reply</a></p>
		                      </div>
		                     </li>
	                     </ul>
			        </li>   			
    			</ul>
    		</div>   	
    	</div>
    	</div>
    </section>
    
	<div class="modal-bg" onClick="popClose();"></div>
	<div class="modal-wrap">
		<div class="modal-title">
			<h3>메세지 전송</h3>
		</div>
		<div class="to_from">
			<span>TO. ${userNickname}님</span>
			&nbsp;<span>👉</span>&nbsp;
			<span>FROM. ${dolbom.nickname}님</span>
		</div>		
		<div class="modal-message">
			<c:if test="${dolbom.category eq '제공'}">
				<div>
					<span>돌봄 종류 및 시간을 선택해주세요</span>
				</div>
			<div>
			<select id="workdateKind">
			<c:forEach items="${times}" var="tlist">
				<option><span id="header">${tlist.header}</span>/<span id="kind">${tlist.kind}</span></option>
			</c:forEach>
			</select>
			</div>
			
			</c:if>
			<c:if test="${dolbom.category eq '요청'}">
				<div>
					<span>돌봄 종류 및 시간을 확인해주세요</span>
				</div>
				<div>
					<span id="header">${dolbom.header}</span>/<span id="kind">${dolbom.kind}</span>
				</div>
			</c:if>
			<textarea id="textMsg" name="textMsg" cols="45" rows="5" placeholder="보내실 메세지를 입력해주세요(50자 이내)"></textarea>
			<div class="countText">
				<span>텍스트입력(</span><span id="cntSPAN">0</span><span>/50 bytes)</span>
			</div>			
		</div>
		<div>
			<input type="hidden" id="dol_seq" name="dol_seq" value="${dolbom.dol_seq}">
		  <button class="submitMsgBtn" onClick="submitMsg('${dolbom.category}');">전송</button>
		  <button class="modal-close" onClick="popClose();">닫기</button>
		</div>
	</div>
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script>
	/*돕기/요청버튼 클릭시 로그인 체크*/
	function check(){
		if(${not empty sessionScope.email}){
			popOpen();
		}else{
			alert("로그인 후 이용해주세요!");
		}
	}
	/*메세지 텍스트 입력 수*/
	$(document).on('keyup', '#textMsg', function(e){
		var textMsg = $(this).val();    
		$('#cntSPAN').text(getBytes(textMsg));
	});
	
	function getBytes(str){
		var cnt = 0;
		for(var i =0; i<str.length;i++) {
			cnt += (str.charCodeAt(i) >128) ? 2 : 1;
		}
		return cnt;
	}

	/*메세지 모달 팝업 창*/
	function popOpen() {	
	    var modalPop = $('.modal-wrap');
	    var modalBg = $('.modal-bg'); 	
	    $(modalPop).show();
	    $(modalBg).show();
	
	}
	function popClose() {
	   var modalPop = $('.modal-wrap');
	   var modalBg = $('.modal-bg');	
	   $(modalPop).hide();
	   $(modalBg).hide();
	}
	/*메세지 전송*/
	function submitMsg(category){
		var msg = $("#textMsg").val();
		var dol_seq = $("#dol_seq").val();
		/*var date = $("#workdate").val();
		var sAmPm = $("#selectSTime").val();
		var timeSTable = $("#timeSTable").val();
		var eAmPm = $("#selectETime").val();
		var timeETable = $("#timeETable").val();
		var kind = $("input[name='kind']:checked").val();*/
		if(category == '제공'){
			var workdateKind = $("#workdateKind option:selected").val();
			var header = workdateKind.split('/')[0];
			var kind = workdateKind.split('/')[1];
		}else{
			var kind = $("#kind").text();
			var header = $("#header").text();
		}				
		alert(kind);
		alert(header);
		console.log(msg);
		$.ajax({
	    	url: "../dolbom/requestdolbom.json",
			type: "POST",
			//data: {dol_seq:dol_seq,msg:msg,workdate:date,selectSTime:sAmPm,timeSTable:timeSTable,selectETime:eAmPm,timeETable:timeETable,kind:kind},
			data: {dol_seq:dol_seq,msg:msg,kind:kind,header:header},
			success:function(data){
				alert("요청성공!");
				$("#textMsg").val('');
				popClose();
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

    <%@include file="../footer.jsp" %>
  </body>
</html>
