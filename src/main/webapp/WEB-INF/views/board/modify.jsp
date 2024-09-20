<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="ko">
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
    	$("button").on("click", function(e){
    		var formData=$("#frm");
    		var btn=$(this).data("btn"); // data-btn="list"
    		if(btn=='modify'){
    			formData.attr("action", "${contextPath}/board/modify.do");
    		}else if(btn=='remove'){
    			formData.find("#title").remove();
    			formData.find("#content").remove();
    			formData.find("#writer").remove();
    			formData.attr("action", "${contextPath}/board/remove.do");
    			formData.attr("method", "get")
    		}else if(btn=='list'){
    			formData.find("#idx").remove();
    			formData.find("#title").remove();
    			formData.find("#content").remove();
    			formData.find("#writer").remove();
    			formData.attr("action", "${contextPath}/board/list.do");
    			formData.attr("method", "get")
    		}
    		formData.submit();    		
    	});    	
    });
  </script>
</head>
<body>
<header>
  <jsp:include page="../common/header.jsp"/>
</header>
<div class="container">
  <div class="card">
	  <div class="card-header">수정화면</div>
	  <div class="card-body">
		 <form id="frm" method="post">
		   <input type="hidden" name="idx" value="${vo.idx}"/>
		   <input type="hidden" name="page" value="<c:out value='${cri.page}'/>"/>
	       <input type="hidden" name="perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
	       <input type="hidden" name="type" value="${cri.type}"/>
	       <input type="hidden" name="keyword" value="${cri.keyword}"/>
	       <input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
		   <table class=table>
		  		<tr>
		  			<td>번호</td>
		  			<td>${vo.idx}</td>	
		  		</tr>
		  		<tr>
		  			<td>제목</td>
		  			<td><input type="text" class="form-control" name="title" value=<c:out value="${vo.title}"/>></td>	
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
		  			  <button type="button" data-btn="list" class="btn-primary btn-sm">리스트</button>
		  			</td>
		  		</tr>
		  	</table>
		 </form>
	  </div>
   </div>
</div>
<footer>
   <jsp:include page="../common/footer.jsp"></jsp:include>
</footer>  
</body>
</html>
