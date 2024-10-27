<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>  
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 



<div class="card" style="min-height: 500px;max-height: 1000px;">
   <div class="row">
     <div class="col-lg-12">
       <div class="card-body">
         <c:if test="${empty mvo.member}">
	         <h4 class="card-title">GUEST</h4>
	         <form action="${contextPath}/memLogin.do" method="post">
	            <input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
	            <div class="form-group">
			      <label for="username">아이디:</label>
			      <input type="text" id="username" class="form-control" name="username">
			    </div>
			    <div class="form-group">
			      <label for="password">비밀번호:</label>
			      <input type="password" id="password" class="form-control" name="password">
			    </div>
			    <button type="submit" class="btn btn-primary form-control">로그인</button>
	         </form>
         </c:if>
         <c:if test="${!empty mvo.member}">
	         <h5 class="jua-regular">${mvo.member.memID} 님 환영합니다.</h5>
          <c:if test="${empty mvo.member.memProfile}">
			 <img class="img-circle" src="${contextPath}/resources/images/basic.PNG" style="width: 100px; height: 100px";/>
		  </c:if>
		  <c:if test="${!empty mvo.member.memProfile}">
			 <img class="img-circle" src="${contextPath}/resources/upload/${mvo.member.memProfile}" style="width: 100px; height: 100px";/>
		  </c:if>	
		  
			 <span class="jua-regular">( </span>
			 
			 <security:authorize access="hasRole('ROLE_USER')"> 
			    <span class="jua-regular">  U </span>
			 </security:authorize> 
			 <security:authorize access="hasRole('ROLE_MANAGER')"> 
			    <span class="jua-regular">  M </span>
			 </security:authorize>  
			 <security:authorize access="hasRole('ROLE_ADMIN')">
			    <span class="jua-regular">  A </span>
			 </security:authorize>
			 
			 <span class="jua-regular"> )</span>
		  
			 <form action="${contextPath}/logout" method="post">
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>		  
			      <button type="submit" class="btn btn-primary form-control" style="margin-top: 20px;">로그아웃</button>
			 </form>
		</c:if>
       </div>
     </div>
   </div>    
   <div class="row">
     <div class="col-lg-12">
       <div class="card-body">
         <h5 class="card-text">MAP VIEW</h5>
         <div class="input-group mb-3">
             <input type="text" class="form-control" id="address" placeholder="Search"/>
             <div class="input-group-append">
               <button type="button" class="btn btn-secondary" id="mapBtn">Go</button>             
             </div>         
         </div>
         <div id="map" style="width:100%;height:150px;"></div>
       </div>
     </div>
   </div>
</div>