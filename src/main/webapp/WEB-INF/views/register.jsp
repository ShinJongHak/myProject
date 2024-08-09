<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contexPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  function goList(){
	  location.href="${contexPath}/board/list"
  }
  
  
  </script>
</head>
<body>
    <div class="panel panel-default">
      <h2>Panel Heading</h2>
	  <div class="panel-heading">Panel Heading</div>
	  <div class="panel-body">
	  <form action="${contexPath}/board/register" method="post">
	  <input type="hidden" name="memID" value="${mvo.memID}"> 
	  	<table class=table>
	  		<tr>
	  			<td>제목</td>
	  			<td><input type="text" name="title" class="form-control"></td>	
	  		</tr>
	  		<tr>
	  			<td>내용</td>
	  			<td><textarea row="7" name="content" class="form-control"></textarea></td>	
	  		</tr>
	  		<tr>
	  			<td>작성자</td>
	  			<td><input type="text" name="writer" value="${mvo.memName}" class="form-control" readonly="readonly"></td>	
	  		</tr>
	  		
	  		<tr>
	  			<td colspan="2" align="center">
	  			  <button type="submit" class="btn btn-primary btn-sm">등록</button>
	  			  <button type="reset" class="btn btn-primary btn-sm">취소</button>
	  			  <button type="button" onclick="goList()" class="btn btn-primary btn-sm">리스트</button>
	  			</td>
	  		</tr>
	  	</table>
	  </form>
	  </div>
      <div class="panel-footer">Panel Footer</div>

   </div>

</body>
</html>
