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
    		if(btn=='reply'){
    			formData.attr("action", "${contexPath}/board/reply");
    			
    		}else if(btn=='modify'){
    			formData.attr("action", "${contexPath}/board/modify");
    			
    		}else if(btn=='list'){
    			formData.find("#idx").remove();
    			formData.attr("action", "${contexPath}/board/list");
    		}
    		else if(btn=='remove'){
        			formData.attr("action", "${contexPath}/board/remove");
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
	  	<table class=table>
	  		<tr>
	  			<td>번호</td>
	  			<td>${vo.idx}</td>	
	  		</tr>
	  		<tr>
	  			<td>제목</td>
	  			<td><c:out value="${vo.title}"/></td>	
	  		</tr>
	  		<tr>
	  			<td>내용</td>
	  			<td><textarea row="7" name="content" class="form-control" readonly="readonly">${vo.content}</textarea></td>	
	  		</tr>
	  		<tr>
	  			<td>작성자</td>
	  			<td>${vo.writer}</td>	
	  		</tr>
	  		
	  		<tr>
	  			<td colspan="2" align="center">
	  			<c:if test="${!empty mvo && mvo.memID eq vo.memID}">
	  			  <button type="button" data-btn="modify" class="btn-primary btn-sm">수정화면</button>
	  			  <button type="button" data-btn="remove" class="btn-warning btn-sm">삭제</button>
	  			  <button type="button" data-btn="list" class="btn btn-primary btn-sm">리스트</button>
	  			</c:if>
	  			<c:if test="${!empty mvo && mvo.memID ne vo.memID}">
	  			  <button type="button" data-btn="reply" class="btn-primary btn-sm">답글</button>
	  			  <button type="button" data-btn="list" class="btn btn-primary btn-sm">리스트</button>
	  			</c:if>
	  			<c:if test="${empty mvo}">
	  			  <button type="button" data-btn="list" class="btn btn-primary btn-sm">리스트</button>
	  			</c:if>
	  			</td>
	  		</tr>
	  	</table>
	  <form id="frm" method="get">
          <input type="hidden" id="idx" name="idx" value="<c:out value='${vo.idx}'/>"/> 
          <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
          <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
          <input type="hidden" name="type" value="${cri.type}"/>
          <input type="hidden" name="keyword" value="${cri.keyword}"/>
      </form>
	  </div>
      <div class="panel-footer">Panel Footer</div>

   </div>

</body>
</html>
