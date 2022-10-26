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
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <!-- 부트스트랩 아이콘 스타일시트 추가-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <!-- selectbox 추가-->
    <link rel="stylesheet" href="/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	
    <style>
    .dolbom_lists{
   	width: 100%;
   	position: relative;
   	padding: 0px 0 10px 0;
   	clear: both;
   	margin:0px 0 20px 0;
    }
    .employer_info{
	width: 100%;
   	position: relative;
   	padding: 10px 0;
   	clear: both;
   	margin:10px 0 10px 0;
    }
    .photo .profile_img{
    padding: 5px;
    width: 200px;
    height: 200px;
    float: left;
    margin-right: 10px;
    text-align: center;
    background-color:gray;
    }
    .info .kind {
    padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
	}
	.info .state{
	padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
    text-align: right;
	}
	.dolbom_lists .row .col-md-6{
	border: 1px solid #F7F1F1;
	border-radius: 10px;
	background-color:#F7F1F1;
	margin: 10px 0 10px 0;
	}
	.searchbox{
	padding:2px 0 2px 0;
	border-bottom:1px solid #ccc;
	}
	.headtitle{
	margin:auto;
	padding:5% 0 0 0;
	text-align:center;
	font-weight:bold;
	}
	.headtitle h3{
	background: linear-gradient(45deg, Violet, Orange);
	color:white;
	border-radius:5px;	
	}
	input[type=date]::before {
		content:attr(data-placeholder);width:100%
	}
	input[type=date]:focus::before, 
	input[type=date]:valid::before {display:none}
	.writeBtn{
		background: linear-gradient(45deg, Violet, Orange);
		border-radius:10px;
		border:0;
		outline:0;
	}
	#conditions{
		margin:3% 0 0 0;
	}
    </style>
  </head>
<body>
<%@include file="../header.jsp" %>
    
    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
	    	<div class="headtitle">
	    		<c:choose>
	    			<c:when test="${empty mydong}"><h3>내 동네 등록하러 가기&nbsp;
		    			<a href="javascript:check();" style="text-decoration:none;"><i class="bi bi-arrow-right-circle"></i></a></h3>
		    		</c:when>
	    			<c:otherwise><h3><i class="bi bi-geo-alt"></i>&nbsp;${mydong}</h3></c:otherwise>
	    		</c:choose>
	    	</div>
			<div class="searchbox">
				<div class="row justify-content-center">
			         <div class="col-md-2">
					    <select class="selectpicker form-control" id="category" onchange="selectOption();" title="돌봄유형">
					    	<!-- <option data-hidden="true" value="">돌봄유형</option> -->
					    	<option value="제공">돌봄제공</option>
					    	<option value="요청">돌봄요청</option>
					    </select>
					 </div>
					 <div class="col-md-2">
					    <select class="selectpicker form-control" id="kind" onchange="selectOption();" title="돌봄종류">
					    	<!-- <option data-hidden="true" value="">돌봄종류</option> -->
					    	<option value="산책">산책</option>
					    	<option value="방문돌봄">방문돌봄</option>
					    	<option value="위탁돌봄">위탁돌봄</option>
					    </select>
					 </div>
        
			        <div class="col-md-4">
			          <select class="selectpicker form-control" id="neighbor" onchange="selectOption();" title="희망이웃선택" multiple >
			          <option data-hidden="true" value="">돌봄유형</option>
				          <optgroup label="성별">
					        <option value="남성">남성</option>
					        <option value="여성">여성</option>
				          </optgroup>	
				        <optgroup label="유형">
					        <option value="견주">견주</option>
					        <option value="집사">집사</option>
				        </optgroup>
				        <optgroup label="사전만남">
					        <option value="사전만남">사전만남</option>
				        </optgroup>
				      </select>
					</div>
					<div class="col-md-2">
				         <input type="date" class="datepicker" id="workdate" data-placeholder="날짜선택" onclick="selectOption()" required aria-required="true" style="border:none;"/>
					</div>
					<div class="col-md-2">
						<select class="selectpicker form-control" id="kind" multiple title="시간선택" onchange="selectOption();">
					    	<option data-hidden="true" value="">시간선택</option>
					    	<option value="새벽">새벽</option>
					    	<option value="오전">오전</option>
					    	<option value="오후">오후</option>
					    	<option value="저녁">저녁</option>
					    </select>
					</div>
			    </div>
			  </div>
  
			  <div class="row">
				  <div class="col-md-6">
					<a id="reset" href="javascript:reset();"><i class="bi bi-arrow-clockwise"></i>&nbsp;검색 조건 초기화</a>
				  </div>
			  <div class="col-md-6" align="right">
				   	<button type="button" class="writeBtn" onclick="location.href='form_helper.do';">돌보미 할래요</button>
				   	<button type="button" class="writeBtn" onclick="location.href='form_receiver.do';">돌보미 필요해요</button>	
			  </div>
			 </div>
			 <div class="row">
				 <div class="col-md-12" id="conditions" style="text-align:right;">
					최신순 | 거리순 | 인기순
			  	 </div>
			 </div>
    		
    		 <div class="dolbom_lists">
	    		<div class="row">
	    		<c:forEach items="${dolbom}" var="dolbom">
		    		<div class="col-md-6">
		    			<div class="employer_info">
    						<div class="photo">
    							<img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">
    						</div>
	    					<div class="info">
	    						<div>
			    					<span class="kind"><strong>돌봄 ${dolbom.category}</strong></span>
			    					<span class="state"><strong>${dolbom.state}</strong></span>
			    					<h5><a href="/dolbom/content.do?dol_seq=${dolbom.dol_seq}">${dolbom.header}</a></h5>
			    				</div>
			    				<div>
			    					<span class="writer">${dolbom.nickname}</span>
			    					&nbsp;·&nbsp;
			    					<span class="addr">${dolbom.region}</span>
			    					
		    					</div>
			    				<div>
			    					<span class="tags"><strong>${dolbom.tag}</strong></span>
			    				</div>
			    				<div>
			    					<span class="chat">채팅1</span>
			    					<span class="views">조회수</span>
			    					<span class="wdate">${dolbom.wdate}</span>
			    				</div>		    				
	    					</div>
	    				</div>
		    		</div>
		    	</c:forEach>
		    	</div>
		    </div> 

			<div class="row mt-5">
	          <div class="col text-center">
	            <div class="block-27">
	              <ul>
	              	<c:if test="${page.prev == true}">
	                <li><a href="search.do?cp=${page.currentPage-1}">&lt;</a></li>
	                </c:if>
	                <!-- <li class="active"><span>0</span></li> -->
	                <c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">
	                	<c:choose>
	                		<c:when test="${i==page.currentPage}">
	                			<li class="active"><a href="search.do?cp=${i}"><span>${i}</span></a></li>
	                		</c:when>
	                		<c:otherwise>
			                	<li><a href="search.do?cp=${i}">${i}</a></li>
			                </c:otherwise>
			            </c:choose>
	                </c:forEach>
	                <c:if test="${page.next == true}">
	                <li><a href="search.do?cp=${page.currentPage+1}">&gt;</a></li>
	                </c:if>
	              </ul>
	            </div>
	          </div>
	        </div>
        </div>
    </section>
  
  <%@include file="../footer.jsp" %>
  <script>
  /*오늘날짜 기본값으로 설정*/
  	//document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
  function selectOption(){		
	  	var neighbor = [];
	  		$("#neighbor option:selected").each(function(i) {
	  			neighbor.push($(this).val());
		    });
		 if(neighbor==''){
			 neighbor = [''];
		 }
		 var category = $("#category option:selected").val();
		 var kind = $("#kind option:selected").val();
		 var workdate = $("#workdate").val();
		 
		 $.ajax({
			 url: "../dolbom/searchOption.json",
			 type: "GET",
			 data: {neighbor:neighbor,category:category,kind:kind,workdate:workdate
			 },
			 success: function(data){
				 var html = "";
				 html += '<div class="row">';
				 for(var i=0;i<data.length;i++){					 
					 html += '<div class="col-md-6">';
					 html += '<div class="employer_info">';
					 html += '<div class="photo">';
					 html += '<img class="profile_img" src="https://source.unsplash.com/600x300/?student" alt="student dp">';
			    	 html += '</div>';
			    	 html += '<div class="info">';
			    	 html += '<div>';
			    	 html += '<span class="kind"><strong>돌봄'+data[i].category+'</strong></span>';
			    	 html += '<span class="state"><strong>'+data[i].state+'</strong></span>';
			    	 html += '<h5><a href="/dolbom/content.do?dol_seq='+data[i].dol_seq+'">'+data[i].header+'</a></h5>';
			    	 html += '</div>';
			         html += '<div>';
			    	 html += '<span class="writer">'+data[i].nickname+'</span>&nbsp;·&nbsp;';
			    	 html += '<span class="addr">'+data[i].region+'</span>';
			    	 html += '</div>';
			    	 html += '<div>';
			    	 html += '<span class="tags"><strong>'+data[i].tag+'</strong></span>';
			    	 html += '</div>';
			    	 html += '<div>';
			    	 html += '<span class="chat">채팅1</span>';
			    	 html += '<span class="views">조회수</span>';
			    	 html += '<span class="wdate">'+data[i].wdate+'</span>';
			    	 html += '</div>';
			    	 html += '</div>';
			    	 html += '</div>';
			    	 html += '</div>';
				 }
				 html += '</div>';
				 $('.dolbom_lists').empty();
				 $('.dolbom_lists').html(html);	
			 }
		 });

	}
  function reset(){
	  //$("#category option").prop("selected", false);
	  //$("#category option:selected").val(""); 
	  //$("#category option:eq(0)").prop("selected", true);
	  //$("#category").val("all").prop("selected", true);
	  //$("#category").children('option').empty();
	  //alert(category);
  }
  function check(){
		if(${not empty sessionScope.email}){
			location.href="/address/setting";
		}else{
			alert("로그인 후 이용해주세요!");
		}
	}

  </script>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
 <!-- select box 추가  jquery-3.3.1-->
  <!-- <script src="/js/jquery-3.3.1.min.js"></script> -->
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
   <!-- select box 추가  bootstrap-select-->
  <script src="/js/bootstrap-select.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <!-- <script src="/js/bootstrap-datepicker.js"></script> -->
  <!-- <script src="/js/jquery.timepicker.min.js"></script> -->
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>

  </body>
</html>