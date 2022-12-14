<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 
    <link rel="stylesheet" href="/css/animate.css">
    
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">


    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
<!--     <link rel="stylesheet" href="/css/jquery.timepicker.css"> -->

    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    <!-- datepovker-korean -->
    
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
  	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
  	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    
 <style>
    .dolbom_lists{
     	width: 100%;
      	position: relative;
    	padding: 10px 0 10px 0;
    	clear: both;
    	margin:20px 0 20px 0;
    }
    .employer_info{
  width: 100%;
      	position: relative;
    	padding: 10px 0;
    	clear: both;
    	margin:10px 0 10px 0;
    }
    .photo{
        padding-top: 10px;
    padding-left: 10px;
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
	searchbox .row. col-md-6{
	padding: 20px;}
	
	button .kind{
	position: relative;
    color: #5f6368;
    border: solid 1px #5f6368;
    border-radius: 1vw;
    padding: 6px 8px 6px 8px; 
    text-decoration: none;
	}
	button .kind:hover{
	color: ;border-color: #4285f4;
    color: #4285f4;
    background: #e9f1fe;
	}

	.row .col-md-6{
	margin:10px 0 10px 0;
	}
	.row .col-md-12{
	margin:10px 0 10px 0;
	}
	.searchbox{
	padding:5%;
	}
	
	
    </style>
  </head>
<body>
<%@include file="../header.jsp" %>
    
    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    		<div style="text-align:center;padding:10px;margin:10px;border-bottom: 1px solid #ccc;">
			    <div class="searchbox">
				    <div class="row">
				    	<div class="col-md-6">
						    <div class="searchAddr">
						    	<p style="font-size: 15px; font-weight: 600; color: rgb(57, 60, 71); margin-left: 3px;text-align:left;">??? ?????? ???????????? ???????????????!</p>
						   		<input type="text" class="form-control" placeholder="??? ????????? ???????????????(???.?????????)">
						   	</div>
					   	</div>
					   	<div class="col-md-6">
						   	<div class="searchDate">
						   		<p style="font-size: 15px; font-weight: 600; color: rgb(57, 60, 71); margin-left: 3px;text-align:left;">?????? ????????????????</p>
						   		<input type="text" class="form-control" name="daterange" value="">
						   	</div>
						</div>
						
	
						<div class="col-md-12">
							<p style="font-size: 15px; font-weight: 600; color: rgb(57, 60, 71); margin-left: 3px;text-align:left;">???????????? ????????? ??????????????????</p>
							<div>
								<p>????????????</p>
								<input type="submit" value="??????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="????????????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="????????????" class="btn btn-primary py-2 px-3">
							</div>
							<div>
								<p>???????????????</p>
								<input type="submit" value="??????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="??????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="??????????????????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="??????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="??????" class="btn btn-primary py-2 px-3">
								<input type="submit" value="???????????? ??????" class="btn btn-primary py-2 px-3">
							</div>
						</div>

					</div>
			    </div>
			    
			 </div>
			 <div class="btn_wrap" style="padding:10px">
			    	<input type="submit" value="??????" class="btn py-3 px-3 btn-dark">
			    	<button type="button" class="btn py-3 px-4 btn-success" onclick="location.href='form_helper.do';">?????????</button>
			    	<button type="button" class="btn py-3 px-4 btn-danger" onclick="location.href='form_receiver.do';">?????????</button>  	
			 </div>

			 
			 <div class="showAll">
			 	<div class="title" style="display:flex; justify-content:space-between;">
			 		<span>???????????? ??????????????? ?????? ???????????????</span>
			 		<button class="showAllBtn">????????????></button>
			 	</div>
		 		<div class="row">
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 		</div> 	
			 </div>
			 
			 <div class="showRecmd">
			 	<div class="title" style="display:flex; justify-content:space-between;">
			 		<span>Best ?????? ???????????? ???????????????</span>
			 		<button class="showAllBtn">????????????></button>
			 	</div>
		 		<div class="row">
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 		</div> 	
			 </div>
			 
			 <div class="showHelp">
			 	<div class="title" style="display:flex; justify-content:space-between;">
			 		<span>???????????? ???????????? ???????????????!</span>
			 		<button class="showAllBtn">????????????></button>
			 	</div>
		 		<div class="row">
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 			<div class="col-md-3">
		 				<span>?????????</span>
		 			</div>
		 		</div> 	
			 </div>
    		
    		
    		<div class="dolbom_lists">
	    		<div class="row">
	    		<c:forEach items="${dolbom}" var="dolbom">
		    		<div class="col-md-6">
		    			<div class="employer_info">
    						<div class="photo">
    							?????????????????????
    						</div>
	    					<div class="info">
	    						<div>
			    					<span class="kind"><strong>?????? ${dolbom.category}</strong></span>
			    					<span class="state"><strong>${dolbom.state}</strong></span>
			    					<h5><a href="/dolbom/content.do?seq=${dolbom.seq}">${dolbom.header}</a></h5>
			    				</div>
			    				
			    				<div>
			    					<a href="/dolbom/content.do?seq=${dolbom.seq}"><span class="title"><strong>${dolbom.title}</strong></span></a>
			    				</div>
			    				<div>
			    					<span class="writer">${dolbom.nickname}</span>
			    					&nbsp;??&nbsp;
			    					<span class="addr">${dolbom.region}</span>
			    					
		    					</div>
			    				<div>
			    					<span class="tags"><strong>${dolbom.tag}</strong></span>
			    				</div>
			    				<div>
			    					<span class="chat">??????1</span>
			    					<span class="views">?????????</span>
			    					<span class="wdate">????????????</span>
			    					<span class="likes">?????????</span>
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

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script>
$(function () {
    $('input[name="daterange"]').daterangepicker(
      {
        locale: {
          format: "YYYY-MM-DD",
          separator: " ~ ",
          applyLabel: "??????",
          cancelLabel: "??????",
          fromLabel: "From",
          toLabel: "To",
          customRangeLabel: "Custom",
          weekLabel: "W",
          daysOfWeek: ["???", "???", "???", "???", "???", "???", "???"],
          monthNames: [
            "1???",
            "2???",
            "3???",
            "4???",
            "5???",
            "6???",
            "7???",
            "8???",
            "9???",
            "10???",
            "11???",
            "12???",
          ],
        },
        startDate: $('input[name="startDate"]').val(),
        endDate: $('input[name="endDate"]').val(),
        drops: "auto",
      },
      function (start, end, label) {
        $('input[name="startDate"]').val(start.format("YYYY-MM-DD"));
        $('input[name="endDate"]').val(end.format("YYYY-MM-DD"));
        console.log(
          "A new date selection was made: " +
            start.format("YYYY-MM-DD") +
            " to " +
            end.format("YYYY-MM-DD")
        );
      }
    );
  });
</script>
<!--   <script src="/js/jquery.min.js"></script>-->
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
<!--   <script src="/js/bootstrap-datepicker.js"></script> -->
<!--   <script src="/js/jquery.timepicker.min.js"></script> -->
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>
	
  </body>
</html>