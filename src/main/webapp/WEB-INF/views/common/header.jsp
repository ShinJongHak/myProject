<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>   
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 

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
	<c:if test="${empty mvo.member}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memLoginForm.do">로그인</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memJoinForm.do">회원가입</a>
	    </li>
	  </ul>
	</c:if>
	<c:if test="${!empty mvo.member}">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memUpdateForm.do">회원정보수정</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="${contextPath}/member/memImageForm.do">사진등록</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="javascript:logout()">로그아웃</a>
	    </li>
	    <c:if test="${!empty mvo.member}">
          <c:if test="${empty mvo.member.memProfile}">
			 <li><img class="img-circle" src="${contextPath}/resources/images/basic.PNG" style="width: 50px; height: 50px";/>
		  </c:if>
		  <c:if test="${!empty mvo.member.memProfile}">
			 <li><img class="img-circle" src="${contextPath}/resources/upload/${mvo.member.memProfile}" style="width: 50px; height: 50px";/>
		  </c:if>	
		   ${mvo.member.memName}님
			     (
			     <security:authorize access="hasRole('ROLE_USER')"> 
			       U,
			     </security:authorize> 
			     <security:authorize access="hasRole('ROLE_MANAGER')"> 
			       M,
			     </security:authorize>  
			     <security:authorize access="hasRole('ROLE_ADMIN')">
			       A
			     </security:authorize>
			      )		
		  </li>  
       </c:if>
	  </ul>
	</c:if>		
  </div>
</nav>