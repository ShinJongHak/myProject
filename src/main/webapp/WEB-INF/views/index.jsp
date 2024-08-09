<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="card">
  <div class="card-header">
	<div class="jumbotron jumbotron-fluid">
	  <div class="container">
	    <h1>Bootstrap Tutorial</h1>
	    <p>Bootstrap is the most popular HTML, CSS...</p>
	  </div>
	</div>
  </div>
  <div class="card-body">
   <h4 class="card-title">Spring boot</h4>
      <div class="row">
         <div class="col-lg-2">
           <div class="card" style="min-height:500px; max-height: 1000px">
             <div class="card-body">
               <h4 class="card-title">GUEST</h4>
               <p class="card-text">회원님 Welcome!</p>
               <form action="">
                 <div class="form-group">
                    <label for="memId">아이디</label>
                    <input type="text" class="form-control" id="memId" name="memId"/>                    
                 </div>
                 <div class="form-group">
                    <label for="memPwd">비밀번호</label>
                    <input type="password" class="form-control" id="memPwd" name="memPwd"/>                    
                 </div>
                 <button type="button" class="btn btn-sm btn-primary form-control">로그인</button>
               </form>
             </div>
           </div>
         </div>
         <div class="col-lg-5">
           <div class="card" style="min-height:500px; max-height: 1000px">
             <div class="card-body">
               <table class="table table-hover">
                 <thead>
                   <th>번호</th>
                   <th>제목</th>
                   <th>작성일</th>
                 </thead>
                 <tbody>
                  <c:forEach var="vo" items="${list}">
                    <tr>
	                   <td>${vo.idx}</td>
	                   <td><a href="${vo.idx}">${vo.title}</a></td>
	                   <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>                    
                    </tr>                    
                  </c:forEach>
                 </tbody>
               </table>
             </div>
           </div>
         </div>
         <div class="col-lg-5">
           <div class="card" style="min-height:500px; max-height: 1000px">
             <div class="card-body">
                <form id="regForm" action="${cpath}/register" method="post">
                 <input type="hidden" id="idx" name="idx" value="${vo.idx}"/>
                 <div class="form-group">
                    <label for="memId">제목:</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Enter title"/>                    
                 </div>
                 <div class="form-group">
                    <label for="content">내용:</label>
                    <textarea rows="9" class="form-control" id="content" name="content"></textarea>                    
                 </div>
                 <div class="form-group">
                    <label for="writer">작성자:</label>
                    <input type="text" class="form-control" id="writer" name="writer" placeholder="Enter writer"/>                    
                 </div>     
                 <div id="regDiv">            
                  <button type="button" data-oper="register" class="btn btn-sm btn-primary">등록</button>
                  <button type="button" data-oper="reset" class="btn btn-sm btn-warning">취소</button>                           
                 </div>
                 <div id="updateDiv" style="display: none">
                  <button type="button" data-oper="list" class="btn btn-sm btn-primary">목록</button>
                  <span id="update"><button type="button" data-oper="updateForm" class="btn btn-sm btn-warning">수정</button></span>
                  <button type="button" data-oper="remove" class="btn btn-sm btn-success">삭제</button>
                 </div>
               </form>            
             </div>
           </div>
         </div>
      </div>    
    </div> 
  </div>
  <div class="card-footer">Footer</div>
</body>
</html>