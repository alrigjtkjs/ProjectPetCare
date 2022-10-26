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
    <style>
    	table.infoview{
    		width:100%;
    		border-collapse: collapse;
  			border-spacing: 1px;
  			text-align: left;
  			line-height: 1.5;
  			border-top: 3px solid black;
  			margin : 20px 10px;
    	}
    	table.infoview th{
  			padding: 10px;
  			font-weight: bold;
  			vertical-align: top;
  			text-align: center;
    	}
    	table.infoview thead{
    		border-bottom: 2px solid black;
    	}
    	table.infoview td {
  		padding: 10px;
  		vertical-align: top;
  		border-bottom: 1px solid #ccc;
		}
		#tablecontent{
			text-align: center;
		}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
    <script>
    function fn_paging(cp) {
    	console.log("cp:"+cp);
    	location.href = "/info/list.do?cp=" + cp;
    	}
    </script>
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Infomation <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">공지사항</h1>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    <table class="infoview">
    <thead>
    <tr>
    	<th>번호</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>조회수</th>
	    <th>날짜</th>
	</tr>
    </thead>
    <tbody>
    <c:forEach items="${listVo.list}" var="infolist">
    <tr>
    <td id="tablecontent">${infolist.n_seq}</td>
    <td><a href="infocontent.do?n_seq=${infolist.n_seq}">${infolist.title}</a></td>
    <td id="tablecontent">${infolist.admin}</td>
    <td id="tablecontent">${infolist.view}</td>
    <td id="tablecontent">${infolist.wdate}</td>
    <td><button type="button" class="deleteButton" id="deleteButton" onclick="location.href='/info/infodelete.do?n_seq=${infolist.n_seq}'">
                        삭제</button></td>
    </tr>
    </c:forEach>
    </tbody>
    </table>
    <!--<hr width='600' size='2' color='gray' noshade>
<font color='gray' size='3' face='휴먼편지체'>
    (총페이지수 : ${listVo.totalPageCount})
    &nbsp;&nbsp;&nbsp;
    <c:forEach begin="1" end="${listVo.totalPageCount}" var="i">
        <a href="list.do?cp=${i}">
   			<c:choose>
   			    <c:when test="${i==listVo.cp}">
                	<strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    ${i}
                </c:otherwise>
			</c:choose>
    	</a>&nbsp;
    </c:forEach>
    ( TOTAL : ${listVo.totalCount} )
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
     -->
    <div>
    <c:if test="${listVo.currentRange ne 1}">
    	<a href="#" onClick="fn_paging(1)">[처음]</a>
    </c:if>
    <c:if test="${listVo.cp ne 1}">
		<a href="#" onClick="fn_paging('${listVo.prevPage }')">[이전]</a> 
	</c:if>
	<c:forEach var="i" begin="${listVo.startPage }" end="${listVo.endPage }">
	<c:choose>
    	<c:when test="${i eq  listVo.cp}">
        	<span style="font-weight: bold;"><a href="#" onClick="fn_paging('${i}')">${i}</a></span> 
		</c:when>
        <c:otherwise>
            <a href="#" onClick="fn_paging('${i}')">${i}</a> 
		</c:otherwise>
	</c:choose>
    	</c:forEach>
        	<c:if test="${listVo.cp ne listVo.totalPageCount && listVo.totalPageCount > 0}">
            	<a href="#" onClick="fn_paging('${listVo.nextPage }')">[다음]</a> 
            </c:if>
	<c:if test="${listVo.currentRange ne listVo.rangeCount && listVo.rangeCount > 0}">
    	<a href="#" onClick="fn_paging('${listVo.totalPageCount }')">[끝]</a> 
	</c:if>
    </div>
    <button onclick="location.href = '/info/infowrite.do' ">글 쓰기</button>
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