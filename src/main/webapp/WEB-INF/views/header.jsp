<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<div class="wrap">
	<div class="container">
		<div class="row">
			<div class="col-md-6 d-flex align-items-center">
				<p class="mb-0 phone pl-md-2">
					<a href="#" class="mr-2"><span class="fa fa-phone mr-1"></span> +00 1234 567</a> 
					<a href="#"><span class="fa fa-paper-plane mr-1"></span> youremail@email.com</a>
				</p>
			</div>
			<div class="col-md-6 d-flex justify-content-md-end">
				<div class="social-media">
	    		<p class="mb-0 d-flex">
	    			<a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-facebook"><i class="sr-only">Facebook</i></span></a>
	    			<a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-twitter"><i class="sr-only">Twitter</i></span></a>
	    			<a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-instagram"><i class="sr-only">Instagram</i></span></a>
	    			<a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-dribbble"><i class="sr-only">Dribbble</i></span></a>
	    		</p>
        		</div>
        		<c:choose>
        			<c:when test="${sessionScope.email != null}">
        				<button type="submit" id="logout-Btn" onclick="location.href = '/member/logout.do'">로그아웃</button>
        				<button type="submit" id="mypage-Btn" onclick="location.href = '/member/mypage.do?email=${sessionScope.email}'">마이 페이지</button>
        			</c:when>
        			<c:otherwise>
        				<button type="submit" id="login-Btn" onclick="location.href = '/member/login.do'">로그인</button>
        				<button type="submit" id="signup-Btn" onclick="location.href = '/member/goSignupM.do'">회원가입</button>
        			</c:otherwise>
        		</c:choose>
        		
			</div>
		</div>
	</div>
</div>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">
    	<a class="navbar-brand" href="/"><span class="flaticon-pawprint-1 mr-2"></span>우리동네 돌보미</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="fa fa-bars"></span> Menu
      </button>
      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
        	<li class="nav-item active"><a href="/" class="nav-link" id="home">홈</a></li>
        	<li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">우리동네 돌보미</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="/dolbom/search.do" id="dolbom">돌보미 찾기</a>
			      <a class="dropdown-item" href="/dolbom/form">돌보미 신청</a>
			      <a class="dropdown-item" href="/dolbom/list.do">돌보미 리스트</a>
			    </div>
			</li>
        	<li class="nav-item"><a href="/review/list.do" class="nav-link" id="review">돌보미 후기</a></li>
        	<li class="nav-item"><a href="/market" class="nav-link" id="market">나눔 마켓</a></li>
          	<li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">커뮤니티</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="/freeboard/galleryList" id="dolbom">갤러리</a>
			      <a class="dropdown-item" href="/freeboard/list">자유게시판</a>
			    </div>
			</li>
			<li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">공지사항</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="/info/list.do" id="dolbom">공지사항</a>
			      <a class="dropdown-item" href="/info/list.do">FAQ</a>
			    </div>
			</li>			
          	<li class="nav-item"><a href="/room" class="nav-link" id="chat">채팅방</a></li>
          	<li class="nav-item"><a href="/admin/main.do" class="nav-link" id="info">관리자</a></li>    	
        </ul>
      </div>
    </div>
  </nav>
  <!-- END nav -->
 
  