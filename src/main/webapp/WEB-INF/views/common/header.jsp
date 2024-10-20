<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>   
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 
<head>
  <link rel="stylesheet" href="${contextPath}/resources/css/image.css" >
</head>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	function logout(){
	  	$.ajax({
	  		url : "${contextPath}/logout",
	  		type: "post",  	
	  		beforeSend: function(xhr){
	              xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	          },
	  		success : function(){
	  			location.href="${contextPath}/";
	  		},
	  		error : function(){ alert("error");}    		
	  	}); 
	}
</script>
    
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="${contextPath}/">
  <img alt="Logo" src="${contextPath}/resources/images/leaf.png" class="logo"/></a>

  <!-- Links -->
  <div class="collapse navbar-collapse justify-content-between">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/">Home</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/board/list.do">게시판</a>
	    </li>
	  </ul>
	<c:if test="${empty mvo.member}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memLoginForm.do">
	      <i class="bi bi-box-arrow-right"></i> 로그인</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memJoinForm.do">
	      <i class="bi bi-person-circle"></i> 회원가입</a>
	    </li>
	  </ul>
	</c:if>
	<c:if test="${!empty mvo.member}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memUpdateForm.do">
	       <i class="bi bi-person-fill-gear"></i> 회원정보수정</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memImageForm.do">
	      <i class="bi bi-image-fill"></i> 사진등록</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="javascript:logout()">
	      <i class="bi bi-box-arrow-left"></i> 로그아웃</a>
	    </li>
	  </ul>
	</c:if>		
  </div>
</nav>