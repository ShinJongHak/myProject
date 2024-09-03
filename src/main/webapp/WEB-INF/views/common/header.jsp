<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>   
    
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="${contextPath}/">Logo</a>

  <!-- Links -->
  <div class="collapse navbar-collapse justify-content-between">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/board/list.do">게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">Link 2</a>
	    </li>
	  </ul>
	<c:if test="${empty mvo}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memLoginForm.do">로그인</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memJoinForm.do">회원가입</a>
	    </li>
	  </ul>
	</c:if>
	<c:if test="${!empty mvo}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memUpdateForm.do">회원정보수정</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memImageForm.do">사진등록</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memLogout.do">로그아웃</a>
	    </li>
	    <c:if test="${!empty mvo}">
          <c:if test="${empty mvo.memProfile}">
			<li><img class="img-circle" src="${contextPath}/resources/images/basic.PNG" style="width: 50px; height: 50px"/> ${mvo.memName} 님Welcome.</li>
		  </c:if>
		  <c:if test="${!empty mvo.memProfile}">
			<li><img class="img-circle" src="${contextPath}/resources/upload/${mvo.memProfile}" style="width: 50px; height: 50px"/> ${mvo.memName} 님Welcome.</li>
		  </c:if>			  
       </c:if>
	  </ul>
	</c:if>		
  </div>
</nav>