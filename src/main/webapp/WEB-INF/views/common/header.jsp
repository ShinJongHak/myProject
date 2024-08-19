<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>   
    
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="#">Logo</a>

  <!-- Links -->
  <div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="#">게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">Link 2</a>
	    </li>
	  </ul>
	<c:if test="${empty mvo}">
	  <ul class="navbar-nav">
	    <!-- Dropdown -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        접속하기
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="${contextPath}/member/memJoin.do">회원가입</a>
	        <a class="dropdown-item" href="${contextPath}/member/memLoginForm.do">로그인</a>
	        <a class="dropdown-item" href="#">Link 3</a>
	      </div>
	    </li>
	  </ul>
	</c:if>
	<c:if test="${!empty mvo}">
	  <ul class="navbar-nav">
	    <!-- Dropdown -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        회원정보
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="${contextPath}/member/memLogout.do">로그아웃</a>
	        <a class="dropdown-item" href="${contextPath}/member/memLoginForm.do">회원정보수정</a>
	        <a class="dropdown-item" href="#">Link 3</a>
	      </div>
	    </li>
	  </ul>
	</c:if>		
  </div>
</nav>