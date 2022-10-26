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
    
    <!-- 드래그앤드랍 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="../js/map.js"></script>
	<script type="text/javascript" src="../js/stringBuffer.js"></script>
    <script>
    
 
    //데이터처리 
    var fd = new FormData();
    var map = new Map();
    function submitFile(){
    	//fd.append('temp', $('#temp').val());
    	sendFileToServer();
    }
    var sendFileToServer = function(){
    	fetch('http://127.0.0.1:8080/info/infotest.do',{
    		method:'POST',
    		body : fd
    	});
    }
    
    function handleFileUpload(files){
    	var megaByte = 1024*1024;
    	for(var i = 0; i < files.length; i++){
    		if(map.containsValue(files[i].name) == false && (files[i].size/megaByte) <=20){
    			fd.append(files[i].name, files[i]);
    			map.put(files[i].name, files[i].name);
    			var tag = createFile(files[i].name, files[i].size);
    			$('#fileTable').append(tag);
    		}else{
    			if((files[i].size/megaByte)>20){
    				alert(files[i].name+"은(는) \n 20메가보다 커서 업로드 불가");
    			}else{
    				alert("중복 파일은 업로드 불가합니다: " + files[i].name);
    			}
    		}
    	}
    }
    
    //업로드 파일목록 생성
    function createFile(fileName, fileSize){
    	var file = {
    			name : fileName,
    			size : fileSize,
    			format : function(){
    				var sizeKB = this.size / 1024;
    				if (parseInt(sizeKB)>1024){
    					var sizeMB = sizeKB /1024;
    					this.size = sizeMB.toFixed(2) + "MB";
    				}else{
    					this.size = sizeKB.toFixed(2) + "KB";
    				}
    				if(name.length>70){
    					this.name = this.name.substr(0,68)+"...";
    				}
    				return this;
    				
    			},
    			tag : function(){
    				var tag = new StringBuffer();
    				console.log("태그생성 위");
    				tag.append('<tr id = "draglist">');
    				tag.append('<td>'+this.name+'</td>');
    				tag.append("<td><input type='button' id='"+this.name+"' onclick='delFile(this)' value='취소'></td>");
    				tag.append('</tr>');
    				return tag.toString();
    			}
    			
    	}
    	return file.format().tag();
    }
    
    function delFile(e){
    	var formName = e.id;
    	
    	fd.delete(formName);
    	
    	map.remove(formName);
    	
    	$(e).parents('#draglist').remove();
    	alert('삭제');
    }
  	//드래그앤드랍 이벤트
    $(document).ready(function(){
    	var objDragDrop = $(".dragDropDiv");
    	$(".dragDropDiv").on("dragover",
    		function(e){
    			console.log("드래그오버1");
    			e.stopPropagation();
    			e.preventDefault();
    			$(this).css('border', '2px solid red');
    	});
		$(".dragDropDiv").on("drop", function(e){
			$(this).css('border', '2px solid green');
			e.preventDefault();
			console.log("드랍");
			var files = e.originalEvent.dataTransfer.files;
			handleFileUpload(files);
		});
		$(document).on('dragover', function(e){
			console.log("드래그오버2");
			e.stopPropagation();
			e.preventDefault();
			objDragDrop.css('border', '2px solid green');
		});
    });
    function check(){
    	for(var i=0; i<document.input.elements.length; i++)
		{
    		if(document.input.elements[i].value == "")
			{
    			alert("모든 값을 입력하셔야 합니다.");
    			return false;
    		}
		}
		 
    	document.input.submit();
    	//fd.append('temp',$('#temp').val());
    	sendFileToServer();
    }
    </script>
   	<style>
  	.dragDropDiv{
  	width:100%;
  	height:100%;
  	text-align:center;
  	border: 2px solid green;
  	}
  	#fileTable{
  		width:100%;
  	}
  	#tabFileName{
  		width: 70%;
  		text-align: left;
  	}
  	#tabFileSize{
  		width: 20%;
  	}
  	#tabFileDel{
  		width: 10%;
  	}
  	.title{
  		width:100%;
  		border: 1px solid #black;
  		border-radius: 1rem;
  	}
  	.content{
  		border: 1px solid #black;
  		border-radius: 1rem;
  	}
  	table{
  		margin: auto;
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
          	<p class="breadcrumbs mb-2"><span>InfoWrite<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">공지사항 작성페이지</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <form name="input" method="post" action="infowrite.do">
    <div class="container">
    
    <div class="input-table">
    	<table>
    	<tbody>
    	<tr><th>제목</th></tr>
    	<tr>
    		<td><input type="text" class="title" name="title" placeholder="제목을 입력하세요"></td>	
    	</tr>
    	<tr><th>내용</th></tr>
    	<tr>
    		<td><textarea rows="10" cols="50" class="content" id="textarea" name="content" placeholder="내용을 입력하세요"></textarea></td>
    	</tr>
    	<tr><th>드래그박스</th></tr>
    	<tr>
    	<td>
    	<div id="fileUpload" class="dragDropDiv">
    	<table id='fileTable'>
    	<tr>
	    	<td id='tabFileName'>파일명</td>
	    	<td id='tabFileDel'>삭제</td>
    	</tr>
    	</table>
    	</div>
    	</td>
    	</tr>
    	</tbody>
    	</table>
		
		<div class="write-btn" align="right">
			<input type="button" class="btn btn-outline-info btn-lg" id="listButton" value="목록"onclick="location.href='/info/list.do'">	
			<input type="button" class="btn btn-info btn-lg" value="전송" onclick="check()">
			<input type="hidden" name="admin" value="관리자" id="admin">
		</div>
    </div>
    </div>
    </form>
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