<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">
    
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 
    <link rel="stylesheet" href="/css/animate.css">
    
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">

    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    <script>
    	 const b_seq = "${shareMarketContents.sm_seq}";
    	 $(function(){
    		var likesSwitch = ${hasLike};
    		if(likesSwitch) $("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
    		console.log("likesSwitch" + likesSwitch);
    		
    		getList(${lastPage}, 5);
    		
    		$(".container").on("click", "#update, #delete, #recomnt, #coUpdate", function(){
    			var crudId = $(this).attr("id");
    			switch(crudId){
	    			case "update": location.href="/market/update?sm_seq=${shareMarketContents.sm_seq}"; break;
	    			case "delete":
	    				$.ajax({
	    					url: "/market/delete.json",
	    					type: "DELETE",
	    					data: {
	    						sm_seq: b_seq	
	    					},
	    					success: function(data){
	    						location.href="/market";
	    					}
	    				})
	    				break;
	    		 	case "recomnt": case "coUpdate":
	    				var parentDiv = $("div#"+$(this).parent().attr("id"));
	    				if($("#"+crudId+"Frame").length){
		    				$("#recomntFrame").remove();
		    				$("#coUpdateFrame").remove();
	    				}else{
	    					$("#recomntFrame").remove();
		    				$("#coUpdateFrame").remove();
		    				createComntFrame(parentDiv, crudId);
	    				}
    			}
    		})
    		$("#heart").on("click", function(){
    			var type = "";
    			console.log(likesSwitch);
    			if(!likesSwitch){
    				console.log("올려");
    				type = "POST";
    				likesSwitch = true;
    			}else if(likesSwitch){
    				console.log("내려");
    				type = "DELETE"
    				likesSwitch = false;
    			}
    			
    			$.ajax({
    				url: "/market/likes.json",
    				type: type,
    				data:{
    					b_seq: b_seq,
    					email: "${email}"
    				},
    				success: function(likes){
    					if(!likesSwitch){
    						$("#heart").removeClass("bi-heart-fill").addClass("bi-heart");
    					}else{
    						$("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
    					}
    					$("#heart_Data").html("&nbsp;"+likes);
    				}
    			})
    			
    		})
    	});

    	// 답글 / 댓글 수정창 띄우기
		function createComntFrame(parentDiv, crudId){
			var html = "";
	 		html += "<div id='"+crudId+"Frame"+"' class='border rounded mb-3'><textarea id='"+crudId+"Area' class='form-control border-0' style='resize:none'></textarea>";
			html += "<div class='text-end'><span id='"+parentDiv.attr('id')+"' name='"+crudId+"Submit' class='btn btn-primary btn-sm px-2 py-1 m-1 fw-bold shadow-sm rounded-pill' onclick='submit(this);'>";
			html += "</span></div></div>";
			$(parentDiv).after(html);
			
			if(crudId == "coUpdate"){
				$("#"+crudId+"Area").val($(parentDiv).children(".comntContents").children("#coContent").text());
				$("span[name="+crudId+"Submit]").text("수정");
			}else{
				$("span[name="+crudId+"Submit]").text("등록");
			}
			$("#"+crudId+"Area").focus();
 		}
				
    	function submit(submitBtn){
   			var submitBtnName = $(submitBtn).attr("name");
   			var cmt_seq = parseInt($(submitBtn).attr("id"));
   			var url, area, type, data = ""; 
   			
			if(submitBtnName == "comntSubmit"){ // 일반 댓글
				url = "/market/comment.json";
				area = "#comntArea";
				type = "POST";
				data = {
					b_seq: b_seq,
					content: $(area).val(),
				};

			}else if(submitBtnName == "recomntSubmit"){ // 답댓글
   				url = "/market/recomment.json";
   				area = "#recomntArea";
   				type = "POST";
 				data = {
 	   				b_seq: b_seq,
 	   				content: $(area).val(),
 	   				gnum: cmt_seq
 	   			};
 				
   			}else if(submitBtnName == "coUpdateSubmit"){ // 수정 버튼
   				url = "/market/comment.json";
   				area = "#coUpdateArea";
   				type = "PUT";
   				data = {
 	   				b_seq: b_seq,
 	   				content: $(area).val(),
 	   				cmt_seq: cmt_seq, 
 	   			};
   			}else if(submitBtnName == "coDeleteSubmit"){
   				url = "/market/comment.json";
   				type = "DELETE";
   				data = {
   					b_seq: b_seq,
   					cmt_seq: cmt_seq
   				}
   			}
			
   			if(area != null){ 
   				if($(area).val().length != 0){
   					console.log("답글수정새글");
	    			$.ajax({
	    				url: url,
	    				type: type,
	    				data: data,
	    				success: function(data){
	    					getList(data, 5);
	    				}
	    			})
   				}else{
   	   				alert("내용을 입력해 주세요.");
   	   			}
   				$(area).val("");
   	   			$(area).blur();
   			}else{
   				$.ajax({
   					url: url,
   					type: type,
   					data: data,
   					success: function(data){
   						if(data){
   							getList(data, 5);
   						}
   					}
   				})
    		}
    	}
    	
    	/* 페이지 번호 받아서 댓글창 보여주기==========================================================================================================  */
    	function getNumber(pageNum){
    		getList(pageNum, 5);
    	}
    	function getList(pageNum, pageSize){
    		$.ajax({
    			url: "/market/comment.json",
    			type: "GET",
    			data: {
    				pageNum: pageNum,
    				pageSize: pageSize,
    				b_seq: "${shareMarketContents.sm_seq}"
    			},
    			success: function(data){
    				updateList(data);
    			}
    		});
    	}
    	function updateList(results){
    		var html;
    		$("#comntFrame").empty(); // 초기화
    		html = "";
    		if(results.lists.length == 0){ // 댓글이 없으면
    			html += "<div class='block-21 d-flex py-5 justify-content-center'> 새로운 댓글을 작성해 보세요 </div>";
    			$("#comntFrame").append(html);
    		}else{
    			$.each(results.lists, function(idx, list){
    				var depth = list.depth*2;
    				if(list.depth == 0 && idx != 0){
    					html += "<div class='border-top mt-3' style='width:97%; margin:0 auto'></div>";
    				}
        			html += "<div id='"+list.cmt_seq+"' class='block-21 d-flex mt-4 mb-3' style='padding-left:"+depth+"rem'>";
        			html += "<div class='comntWriterFrame align-self-top'>";
        			if(list.depth != 0){
        				html += "<span class='bi bi-arrow-return-right position-absolute translate-middle'></span>"
        			}
        			html += "<img class='comntProfile img-fluid rounded-circle position-relative' src='/resources/images/person_1.jpg'></div>";
        			html += "<div class='comntContents align-self-top'>";
        			html += "<div>" + list.email + "</div>";
        			html += "<div id='coContent'>" + list.content + "</div>";
        			html += "<div class='text-end' style='font-size:80%'>" + list.wdate + "</div></div>";
        			if("${email}" != null){
        				html += "<div class='comntOption btn-group'>";
        				html += "<button class='btn p-0' type='button' data-bs-toggle='dropdown' aria-expanded='false'>";
        				html += "<span class='bi bi-three-dots-vertical'></span></button>";
        				html += "<ul id='"+list.cmt_seq+"' class='dropdown-menu'>";
        				html += "<li id='recomnt' class='btn text-secondary p-0'><a class='dropdown-item'>답글</a></li>";
        				if("${email}" == list.email){
        					html += "<li id='coUpdate' class='btn text-secondary p-0'><a class='dropdown-item'>수정</a></li>";
        					html += "<li name='coDeleteSubmit' id='"+list.cmt_seq+"' class='btn text-secondary p-0' onclick='submit(this);'><a class='dropdown-item' onclick='submit(this);'>삭제</a></li>";
        				}
        				html += "</ul></div></div>";
        			}
    			})
    			if(!$(".totalRowCounts").length) $("#comntFrame").before("<div class='totalRowCounts'><span class='bi bi-chat px-1' style='font-size:0.93rem; cursor:pointer' onClick='location.reload();'> 댓글 "+ results.pagination.totalRowCounts + "</span></div>")
    			$("#comntFrame").append(html);
    			$("#prevBtn").html("");
    			if(results.pagination.prev == false){
    				$("#prevBtn").html("<input class='page-link text-light' type='button' value='<<' disabled/>");
    			}else{
    				$("#prevBtn").html("<input class='page-link text-black' type='button' value='<<' onClick=getNumber("+(results.pagination.pageNum-1)+"); />");
    			}
    			
    			html = "";
    			$("li").remove("#pageBtn");
    			for(var i=results.pagination.firstPageScope; i<=results.pagination.lastPageScope; i++){
    				html += "<li id='pageBtn' class='page-item'><input class='page-link ";
    				if(i == results.pagination.pageNum){
    					html += "bg-primary text-white";	
    				}else{
    					html += "text-black";
    				}
    				html += "' type='button' onClick='getNumber("+i+");' value="+i+" /></li>";
    			}
    			$("#prevBtn").after(html);
    			
    			$("#nextBtn").html("");
    			if(results.pagination.next == false){
    				$("#nextBtn").html("<input class='page-link text-light' type='button' value='>>' disabled/>");
    			}else{
    				$("#nextBtn").html("<input class='page-link text-black' type='button' value='>>' onClick='getNumber("+(results.pagination.pageNum+1)+");' />");
    			}
    		}
    	} 
    </script>
    <style>
    	.carousel {
    		margin-top: 1rem;    		
    		margin-bottom: 1.4rem;    		   		
    	}
    	.carousel-item {
    		width: 100%;
    		height: 750px;
    	}
    	.d-block {
    		height: 100% !important;
    		margin: 0 auto;
    	}
    	.imgs{
    		width:100%;
    	}
    	a{
    		color:gray;
    	}
    	.writerFrame{
    		width:60px;
    		float:left;
    		text-align:center;
    	}
    	.writerInfo{
    		width:100%;
    		float:right;
    		padding-left:0.5rem;
    		line-height:130%;
    	}
    	#heart{
    		color:#ff2b53;
    		font-size:1.3rem;
    	}
    	#heart:hover{
    		opacity:0.5;
    	}
    	.comntWriterFrame{
    		width: 40px;
    		float: left;
    		text-align:center;
    	}
    	.comntContents{
    		width:94%;
    		float:right;
    		padding-left:0.5rem;
    	}
    	.comntOption{
    		width:4%;
    		height:30%;
    		float:right;
    		text-align:center;
    	}
    	.dropdown-menu{
    		min-width:4rem;
		}
		.recentFiles{
			width: 80px;
			height: 80px;
		}
		.recentContents{
			font-size:0.8rem;
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
          	<p class="breadcrumbs mb-2"><span>Market<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">나눔 마켓</h1>
          </div>
        </div>
      </div>
    </section>
    <section class="ftco-section bg-light">
	    <div class="container">
		<!-- share market content -->
			<div class="row bg-white shadow">
				<div class="col-lg-8 p-4 col-lg-8 ftco-animate fadeInUp ftco-animated">
					<div class="d-flex align-self-center mb-2"> <!-- 제목 -->
						<h4 class="col-11 title p-0"><span class="badge bg-primary text-wrap rounded-pill shadow-sm p-2">${shareMarketContents.category}</span>&nbsp;&nbsp;${shareMarketContents.title}</h4>
						<div class="col-1 p-0 text-end">
							<i id="heart" class="bi bi-heart"></i>
						</div>
					</div>
					<!-- ------------------------------------------------------------------------------------------------------------------ -->
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
						</div>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/market/display?imgName=고양이_1665058961604.jpg" class="d-block w-100 h-100" alt="...">
							</div>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
						</button>
					</div>
					<!-- ------------------------------------------------------------------------------------------------------------------ -->
					<div>
						<div class="block-21 d-flex mb-3 justify-content-between">
							<div class="writerFrame align-self-center">
								<img class="profile img-fluid rounded-circle" src="/resources/images/profile.jpg">
							</div>
							<div class="writerInfo align-self-center">
								<div class="d-flex justify-content-between">
									<div>${shareMarketContents.email}</div>
									<div class="justify-content-end">
									<c:if test="${shareMarketContents.email eq email}">
									<div class="btn-group">
										<button class="btn p-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
											<span class="bi bi-three-dots-vertical"></span>
										</button>
										<ul id="${shareMarketContents.sm_seq}" class="dropdown-menu">
											<li id="update" class="btn text-secondary p-0"><a class="dropdown-item">수정</a></li>
											<li id="delete" class="btn text-secondary p-0"><a class="dropdown-item">삭제</a></li>
										</ul>
									</div>
									</c:if>
								</div>
								</div>
								<div class="d-flex justify-content-between">
									<div>${shareMarketContents.location}</div>
									<div>
										<span>${shareMarketContents.wdate} · </span>
										<span class="bi bi-eye"> ${shareMarketContents.views} ·</span>
										<span id="heart_Data" class="bi bi-heart-fill"> ${shareMarketContents.likes} </span>
									</div>
								</div>
							</div>
						</div>	
					</div>
					<div>
						<div class='border-top mt-3' style='width:97%; margin:0 auto'></div>
						<div class="p-4 my-2">
						${shareMarketContents.content}
						The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
						</div>
					</div>
					<!-- 댓글 영역 -->
					<div id="comntFrame" class="rounded border px-3 mb-3">
					</div>
					<div>
						<nav class="col-12 col-md-12 mb-2" aria-label="Page navigation example">
							<ul id="pagination" class="pagination pagination-sm justify-content-center">
								<li id="prevBtn" class="page-item">
								</li>
								<li id="nextBtn" class="page-item">
								</li>
							</ul>
						</nav>
					</div>
					<!-- 댓글 입력 -->
					<div>
						<div class="col-12 col-md-12 p-0 mb-3 border rounded">
							<textarea id="comntArea" class="form-control border-0" rows="2" style="resize:none"></textarea>
							<div class="text-end">
								<span name="comntSubmit" class="btn btn-primary btn-sm px-2 py-1 m-1 fw-bold shadow-sm rounded-pill" onclick="submit(this);">등록</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 pb-4 sidebar pl-lg-5 ftco-animate fadeInUp ftco-animated mt-4">
					<form action="#" class="search-form">
						<div class="form-group">
							<span class="fa fa-search"></span>
							<input type="text" class="form-control" placeholder="">
						</div>
					</form>
					<c:if test="${!empty prevContent.shareMarket}">
					<h5>이전 글</h5>
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${prevContent.fname});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${prevContent.shareMarket.sm_seq}">${prevContent.shareMarket.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${prevContent.shareMarket.email}</span></div>
							  <div><span class="icon-calendar">${prevContent.shareMarket.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${prevContent.shareMarket.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${prevContent.shareMarket.likes}</span></div>
							</div>
						</div>
					</div>
					</c:if>
					<c:if test="${!empty nextContent.shareMarket}">
					<h5>다음 글</h5>
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${nextContent.fname});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${nextContent.shareMarket.sm_seq}">${nextContent.shareMarket.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${nextContent.shareMarket.email}</span></div>
							  <div><span class="icon-calendar">${nextContent.shareMarket.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${nextContent.shareMarket.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${nextContent.shareMarket.likes}</span></div>
							</div>
						</div>
					</div>
					</c:if>	
					<h5 class="mt-4">최근 본 게시물</h5>
					<c:choose>
					<c:when test="${!empty recentPosts}">
					<c:forEach var="post" items="${recentPosts}">
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${post.recentFileName});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${post.recentPost.sm_seq}">${post.recentPost.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${post.recentPost.email}</span></div>
							  <div><span class="icon-calendar">${post.recentPost.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${post.recentPost.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${post.recentPost.likes}</span></div>
							</div>
						</div>
					</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
					<div class="block-21 mb-4 d-flex">
					<a> 나눔마켓을 둘러보세요 </a>
					</div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		<!-- share market content-->
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