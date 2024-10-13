<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 

<!DOCTYPE html>
<html lang="en">

<title>myHome</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/resources/css/main.css" >
  
<body>
<header>
  <jsp:include page="../common/header.jsp"/>
</header>
<div class="container main">
  <div class="card">
    <div class="card-header">등록화면</div>
    <div class="card-body">
        <form action="${contextPath}/board/register.do" method="post">
          <input type="hidden" name="memID" value="${mvo.member.memID}"/>
          <input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <div class="form-group">
             <label>제목</label>
             <input type="text" name="title" class="form-control">
          </div>
          <div class="form-group">
             <label>내용</label>
             <textarea rows="10" name="content" class="form-control"></textarea>
          </div>
          <div class="form-group">
             <label>작성자</label>
             <input type="text" readonly="readonly" name="writer" class="form-control" value="${mvo.member.memID}">
          </div>
          <button type="submit" class="btn btn-primary">등록</button>
          <button type="button" onclick="location.href='${contextPath}/board/list.do'"class="btn btn-primary">리스트</button>
       </form>
    </div>
  </div>
</div>
 
 <footer>
     <jsp:include page="../common/footer.jsp"></jsp:include>
 </footer>
 
 
</body>
</html>