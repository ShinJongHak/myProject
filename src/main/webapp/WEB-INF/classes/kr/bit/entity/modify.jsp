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
    $(document).ready(function(){
    	$("button").on("click", function(e){
    		var formData=$("#frm");
    		var btn=$(this).data("btn"); // data-btn="list"
    		if(btn=='modify'){
    			formData.attr("action", "${contexPath}/board/modify");
    		}else if(btn=='remove'){
    			formData.find("#title").remove();
    			formData.find("#content").remove();
    			formData.find("#writer").remove();
    			formData.attr("action", "${contexPath}/board/remove");
    			formData.attr("method", "get")
    		}else if(btn=='list'){
    			formData.find("#idx").remove();
    			formData.find("#title").remove();
    			formData.find("#content").remove();
    			formData.find("#writer").remove();
    			formData.attr("action", "${contexPath}/board/list");
    			formData.attr("method", "get")
    		}
    		formData.submit();    		
    	});    	
    });
  </script>
</head>
<body>
    <div class="panel panel-default">
      <h2>Panel Heading</h2>
	  <div class="panel-heading">Panel Heading</div>
	  <div class="panel-body">
	  <form id="frm" method="post">
	   <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
       <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
       <input type="hidden" name="type" value="${cri.type}"/>
       <input type="hidden" name="keyword" value="${cri.keyword}"/>
	  	<table class=table>
	  		<tr>
	  			<td>번호</td>
	  			<td><input type="text" name="idx" value="${vo.idx}" class="form-control" readonly="readonly"></td>	
	  		</tr>
	  		<tr>
	  			<td>제목</td>
	  			<td><input type="text" name="title" value=<c:out value="${vo.title}"/> class="form-control"></td>	
	  		</tr>
	  		<tr>
	  			<td>내용</td>
	  			<td><textarea row="7" name="content" class="form-control"><c:out value="${vo.content}"/></textarea></td>	
	  		</tr>
	  		<tr>
	  			<td>작성자</td>
	  			<td>${mvo.memID}</td>	
	  		</tr>
	  		
	  		<tr>
	  			<td colspan="2" align="center">
	  			  <button type="button" data-btn="modify" class="btn-primary btn-sm">수정</button>
	  			  <button type="button" data-btn="remove" class="btn-warning btn-sm">삭제</button>
	  			  <button type="button" data-btn="list" class="btn btn-primary btn-sm">리스트</button>
	  			</td>
	  		</tr>
	  	</table>
	  </form>
	  </div>
      <div class="panel-footer">Panel Footer</div>

   </div>

</body>
</html>
