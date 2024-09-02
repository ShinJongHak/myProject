<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <title>myHome</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
  	if(${!empty msgType}){
  		$("#myMessage").modal("show");
  	}
  });
  </script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="card container">
  <div class="card-header">로그인화면</div>
  <div class="card-body">
    <form action="${contextPath}/member/memLogin.do" method="post">
       <table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
         <tr>
           <td style="width: 110px; vertical-align: middle;">아이디</td>
           <td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요."/></td>
         </tr>
         <tr>
           <td style="width: 110px; vertical-align: middle;">비밀번호</td>
           <td colspan="2"><input id="memPassword" name="memPassword" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>            
         </tr>      
         <tr>
           <td colspan="2" style="text-align: left;">
              <input type="submit" class="btn btn-primary btn-sm float-right" value="로그인"/>
           </td>             
         </tr>
       </table>
     </form> 
  </div>
</div>
<footer>
   <jsp:include page="../common/footer.jsp"></jsp:include>
</footer>
</body>
	<!-- Modal 실패메시지 -->
	 <div class="modal" id="myMessage">
	  <div class="modal-dialog">
	    <div id="checkType" class="modal-content">
	
	      <!-- Modal Header -->
	      <div  class="modal-header panel-heading">
	        <h4 class="modal-title">${msgType}</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        <p id="checkMessage">${msg}</p>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</html>