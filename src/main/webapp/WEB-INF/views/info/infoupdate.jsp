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
    <script type="text/javascript" src="/js/map.js"></script>
	<script type="text/javascript" src="/js/stringBuffer.js"></script>
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
  </style>
    
  </head>
  <body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Infoupdate<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">공지사항 수정페이지</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <form name="input" method="post" action="infoupdate.do">
    <input type="hidden" name="n_seq" id="n_seq" value="${infolist.n_seq}"/>
    <div class="container">
    
    <div class="input-table">
    	<table>
    	<tr>
    		<td>제목</td>
    		<td><input type="text" class="" name="title" value="${infolist.title}"></td>	
    	</tr>
    	<tr>
    		<td>내용</td>
    		<td><textarea rows="10" cols="50" class="" name="content">${infolist.content}</textarea></td>
    	</tr>
    	<tr>
    	<td>드래그박스</td>
    	<td>
    	<div id="fileUpload" class="dragDropDiv">
    	<table id='fileTable'>
    	<tr>
	    	<td id='tabFileName'>파일명</td>
	    	<td id='tabFileSize'>사이즈</td>
	    	<td id='tabFileDel'>삭제</td>
    	</tr>
    	<c:forEach var="filelist" items="${filelist}">
		    <tr id="draglist">
		    <td>${filelist.ofname}</td>
		    <td><input type='button' id='${filelist.ofname}' onclick='deletefile(this)' value='취소'></td>
		    </tr>
	    </c:forEach>
    	</table>
    	</div>
    	</td>
    	</tr>
    	</table>
		<div class="write-btn" align="right">
			<button type="button" class="btn btn-outline-info btn-lg" id="listButton" onclick="location.href='/info/list.do'">목록</button>	
			<button type="submit" class="btn btn-info btn-lg" id="saveButton" onclick="check()">작성</button>
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
  
  <script>
    
 
    //데이터처리 
    var fd = new FormData();
    var map = new Map();
    
    var seq = $('#n_seq').val();
    function submitFile(){
    	//fd.append('temp', $('#temp').val());
    	//sendFileToServer();
    }
    var sendFileToServer = function(){
    	fd.append("n_seq", seq);
    	fetch('http://127.0.0.1:8080/info/fileupdate.do',{
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
    	console.log(formName);
    	console.log(e);
    	fd.delete(formName);
    	
    	map.remove(formName);
    	
    	$(e).parents('#draglist').remove();
    	alert('삭제');
    }
    var deleteList = [];
    function deletefile(e){
    	var deleteName = e.id;
    	console.log(deleteName);
    	console.log(e);
    	
    	$(e).parents('#draglist').remove();
    	alert('삭제2');
    	deleteList.push(deleteName);
    }
    function deleteTest(){
    	console.log("deleteList: "+deleteList);
    	console.log("deleteList: "+typeof(deleteList));
    	$.ajax({
    		url : "../info/filedelete.do",
    		type:'GET',
    		data:{ "deleteList": deleteList, "n_seq" : $('#n_seq').val()
    			
    		},
    	});
    	for(var i = 0; i < deleteList.length; i++){
    		console.log("엘렐레");
    	}
    	
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
    		if(i>=3) continue;
    		if(document.input.elements[i].value == "")
			{
    			alert("모든 값을 입력하셔야 합니다.");
    			return false;
    		}
		}
    	document.input.submit();
    	//fd.append('temp',$('#temp').val());
    	sendFileToServer();
    	deleteTest();
    }
    </script>
    
  </body>
</html>