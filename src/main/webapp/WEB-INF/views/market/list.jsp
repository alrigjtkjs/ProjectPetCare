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
    	$(function(){
    		getList(1, 6);
    	})
    	function intoContent(cardObj){
    		location.href="/market/content?sm_seq="+$(cardObj).attr("id");
    	}
    	function getList(pageNum, pageSize){
    		$.ajax({
    			url : "/market/list.json",
    			type : "GET",
    			data : {
    				pageNum : pageNum,
    				pageSize : pageSize,
    				b_seq : "${ShareMarketContents.sm_seq}"
    			},
    			success : function(data){
    				updateList(data);
    			}
    		});
    	}
    	function getNumber(pageNum){
			getList(pageNum, 6);
		}
    	function updateList(results){
    		var html = "";
    		$("#list").empty();
    		if(results.lists.length == 0){
    			$("#list").append("<div class='pb-5 text-center text-secondary'>게시글을 작성해 보세요.</div>");
    		}else{
    			$.each(results.lists, function(idx, list){
    				html += "<div class='col-md-4 col-sm-6 pb-5'>";
    				html += "<div id='"+list.sm_seq+"' class='border-0 shadow card h-100' onClick='intoContent(this);'>";
    				if(results.fnames[idx] == null){
    					html += "<div class='card-img-top bg-light'><div class='bi bi-image'></div><div>No Image Available</div></div>";
    				}else{
    					html += "<img src='/market/display?imgName="+results.fnames[idx]+"' class='card-img-top'>";
    				}
    				html += "<div class='row row-md-12 card-body'>";
    				html += "<div class='card-title'><span class='card-title shadow-sm rounded-pill px-3 py-1' style='background-color:#bdfcd9'>"+list.category+"</span></div>";
    				html += "<div class='card-subtitle'>"+list.title+"</div>";				
    				html += "<div class='card-text align-self-center'><span class='card-text my-0'>"+list.email+"&nbsp;&nbsp;·&nbsp;&nbsp;</span><span class='card-text my-0'>"+list.location+"</span></div>";				
    				html += "<div class='card-text align-self-end text-end'><span>&nbsp;&nbsp;<i class='bi bi-heart-fill'>&nbsp;&nbsp;</i>"+list.likes+"</span><span>&nbsp;&nbsp;<i class='bi bi-eye'>&nbsp;&nbsp;</i>"+list.views+"&nbsp;&nbsp;</span></div>";			
    				html += "</div></div></div>";			
    			})
    			$("#list").html(html);
    			html="";
    			
    			//이전 버튼
    			$("#prevBtn").html("");
    			if(results.pagination.prev == false){
    				$("#prevBtn").html("<input class='page-link text-light' type='button' value='<<' disabled/>");
    			}else{
    				$("#prevBtn").html("<input class='page-link text-black' type='button' value='<<' onClick='getNumber("+results.pagination.firstPageScope+")'/>")
    			}
    			//페이지 번호 버튼
    			$("li").remove("#pageBtn");
    			html="";
    			for(var i=results.pagination.firstPageScope; i<=results.pagination.lastPageScope; i++){
    				html += "<li id='pageBtn' class='page-item'><input class='page-link ";
    				if(i == results.pagination.pageNum){
    					html += "bg-primary text-white";
    				}else{
    					html += "text-black";	
    				}
    				html += "' type='button' onClick=getNumber("+i+") value="+i+" /></li>";
    			}
    			$("#prevBtn").after(html);
    			//다음 버튼
    			$("#nextBtn").html("");
    			if(results.pagination.next == false){
    				$("#nextBtn").html("<input class='page-link text-light' type='button' value='>>' disabled/>")
    			}else{
    				$("#nextBtn").html("<input class='page-link text-black' type='button' onClick='getNumber("+(results.pagination.lastPageScope)+")' value='>>'/>")
    			}
    		}
    	}
    </script>
    <style>
    	.card-img-top{
    		height:60%;
    	}
    	.bi-heart-fill{
    		color:crimson;
    	}
    	.bi-eye{
    		color:black;
    		font-size:1.05rem;
    	}
    	.card{
    		height:100rem;
    		cursor:pointer;
    		
    	}
    	.card:hover{
    		opacity:0.5;
    	}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
    <section class="hero-wrap hero-wrap-2">;
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
		<!-- share market list -->
			<div class="col-12 col-md-12 p-0 mb-4 text-end">
				<input type="button" class="btn btn-success rounded-pill px-2 py-2" value="글쓰기" onClick="location.href='/market/write'" />
			</div>
			<div id="list" class="row row-md-12">
			<!-- updateList() -->
			</div>
			<nav aria-label="Page navigation example">
				<ul id="pagination" class="pagination pagination-sm justify-content-center">
					<li id="prevBtn" class="page-item">
					</li>
					<li id="nextBtn" class="page-item">
					</li>
				</ul>
			</nav>
			<!-- share market -->
		</div>
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