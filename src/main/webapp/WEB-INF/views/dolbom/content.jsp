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
            <h1 class="mb-0 bread">???????????? ?????????</h1>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    	<div class="row">
    		<div class="employer_info">
    			<strong class="title">?????? ??????</strong>
    			<div class="photo">
    				???????????????
    			</div>
    			<div class="info">
    				<div>
    					<h5>[?????? ${dolbom.category}]</h5>
    					<span class="kind"><strong>?????? ??????&nbsp;</strong>${dolbom.kind}</span>
    				</div>
    				<div class="date">
	    				<span class="workdate"><strong>?????? ??????&nbsp;</strong>${dolbom.header}</span>
	    				<c:if test="${dolbom.category eq '??????'}">
	    				<span class="worktime">( ${dolbom.workstime}~${dolbom.worketime} )</span>
	    				</c:if>
    				</div>
    				<div class="wdate"><strong>?????????&nbsp;</strong>${dolbom.wdate}</div>
    				<div>
    					<span class="writer">${dolbom.nickname}</span>
    					&nbsp;??&nbsp;
    					<span class="region">${dolbom.region}</span>	
    				</div>
    				<div><br>
    					<span class="chat">??????1</span>
			    		<span class="views">?????????1</span>
			    		<span class="likes">?????????1</span>
    				</div>
    			</div>
    			<div class="btn_wrap">	
    				<c:if test="${dolbom.category eq '??????'}">	
    				<button type="submit" class="btn btn-info btn-lg" id="help" onclick="check();" style="background-color:#F34A4A;">???????????????????</button>
	    			</c:if>
	    			<c:if test="${dolbom.category eq '??????'}">
	    			<button type="submit" class="btn btn-info btn-lg" id="help" onClick="check();" style="background-color:#F34A4A;">???????????????????</button>
	    			</c:if>
	    			<button type="submit" class="btn btn-info btn-lg" id="profile">????????? ?????????</button>
	    			<button type="submit" class="btn btn-info btn-lg" id="chat" onClick="location.href='/room'">??????</button>
	    			<button type="submit" class="btn btn-info btn-lg" id="declaration"style="background-color:gray;">??????????</button>
	    		</div>
    		</div>
			<div class="employer_text">
				<strong class="title">?????? ??????</strong>
    			<div>${dolbom.content}</div>
    		</div>
    		<div class="petinfo">
    			<strong class="title">???????????? ??????</strong>
    			<div class="row">
    			<div class="col-md-3">
			        <div class="card shadow-sm">
			          <div class="card-header bg-transparent text-center">
			            <img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">
			            <h3>??????</h3>
			          </div>
			          <div class="card-body">
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>?????????</p>
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>????????????</p>
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>&nbsp;??????</p>
			            <p class="mb-0"><strong class="pr-1">??? ???</strong>&nbsp;2???</p>
			            <p class="mb-0"><strong class="pr-1">?????????</strong>&nbsp;O</p>
			            <p class="mb-0">#????????? ???????????? #??????</p>  
			          </div>
			        </div>
		      	</div>
		      	<div class="col-md-3">
			        <div class="card shadow-sm">
			          <div class="card-header bg-transparent text-center">
			            <img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">
			            <h3>??????</h3>
			          </div>
			          <div class="card-body">
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>?????????</p>
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>????????????</p>
			          	<p class="mb-0"><strong class="pr-1">??? ???</strong>&nbsp;??????</p>
			            <p class="mb-0"><strong class="pr-1">??? ???</strong>&nbsp;2???</p>
			            <p class="mb-0"><strong class="pr-1">?????????</strong>&nbsp;O</p>
			            <p class="mb-0">#????????? ???????????? #??????</p>  
			          </div>
			        </div>
		      	</div>
		      	</div>
		    </div>
    		<div class="comments">
    			<strong class="title">??????(2)</strong>
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
			<h3>????????? ??????</h3>
		</div>
		<div class="to_from">
			<span>TO. ${userNickname}???</span>
			&nbsp;<span>????</span>&nbsp;
			<span>FROM. ${dolbom.nickname}???</span>
		</div>		
		<div class="modal-message">
			<c:if test="${dolbom.category eq '??????'}">
				<div>
					<span>?????? ?????? ??? ????????? ??????????????????</span>
				</div>
			<div>
			<select id="workdateKind">
			<c:forEach items="${times}" var="tlist">
				<option><span id="header">${tlist.header}</span>/<span id="kind">${tlist.kind}</span></option>
			</c:forEach>
			</select>
			</div>
			
			</c:if>
			<c:if test="${dolbom.category eq '??????'}">
				<div>
					<span>?????? ?????? ??? ????????? ??????????????????</span>
				</div>
				<div>
					<span id="header">${dolbom.header}</span>/<span id="kind">${dolbom.kind}</span>
				</div>
			</c:if>
			<textarea id="textMsg" name="textMsg" cols="45" rows="5" placeholder="????????? ???????????? ??????????????????(50??? ??????)"></textarea>
			<div class="countText">
				<span>???????????????(</span><span id="cntSPAN">0</span><span>/50 bytes)</span>
			</div>			
		</div>
		<div>
			<input type="hidden" id="dol_seq" name="dol_seq" value="${dolbom.dol_seq}">
		  <button class="submitMsgBtn" onClick="submitMsg('${dolbom.category}');">??????</button>
		  <button class="modal-close" onClick="popClose();">??????</button>
		</div>
	</div>
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script>
	/*??????/???????????? ????????? ????????? ??????*/
	function check(){
		if(${not empty sessionScope.email}){
			popOpen();
		}else{
			alert("????????? ??? ??????????????????!");
		}
	}
	/*????????? ????????? ?????? ???*/
	$(document).on('keyup',??'#textMsg',??function(e){
		var??textMsg??=??$(this).val();????????
		$('#cntSPAN').text(getBytes(textMsg));
	});
	
	function??getBytes(str){
		var??cnt??=??0;
		for(var??i??=0;??i<str.length;i++)??{
			cnt??+=??(str.charCodeAt(i)??>128)?????2??:??1;
		}
		return??cnt;
	}

	/*????????? ?????? ?????? ???*/
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
	/*????????? ??????*/
	function submitMsg(category){
		var msg = $("#textMsg").val();
		var dol_seq = $("#dol_seq").val();
		/*var date = $("#workdate").val();
		var sAmPm = $("#selectSTime").val();
		var timeSTable = $("#timeSTable").val();
		var eAmPm = $("#selectETime").val();
		var timeETable = $("#timeETable").val();
		var kind = $("input[name='kind']:checked").val();*/
		if(category == '??????'){
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
				alert("????????????!");
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
