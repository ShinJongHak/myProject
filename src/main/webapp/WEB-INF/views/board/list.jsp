<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>myHome</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/resources/css/list.css">
  <script type="text/javascript">
     $(document).ready(function(){
    	var result='${result}'; 
    	checkModal(result); 
    	 
    	$("#regBtn").click(function(){
    		location.href="${contextPath}/board/register.do";
    	}); 
    	//페이지 번호 클릭시 이동 하기
    	var pageFrm=$("#pageFrm");
    	$(".paginate_button a").on("click", function(e){
    		e.preventDefault(); // a tag의 기능을 막는 부분
    		var page=$(this).attr("href"); // 페이지번호
    		pageFrm.find("#page").val(page);
    		pageFrm.submit(); // /sp08/board/list   		
    	});    	
    	// 상세보기 클릭시 이동 하기
    	$(".move").on("click", function(e){
    		e.preventDefault(); // a tag의 기능을 막는 부분
    		var idx=$(this).attr("href");
    		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
    		pageFrm.append(tag);
    		pageFrm.attr("action","${cpath}/board/get");
    		pageFrm.attr("method", "get");
    		pageFrm.submit();
    	});
    	
     });
     function checkModal(result){
    	 if(result==''){
    		 return;
    	 }    	 
    	 if(parseInt(result)>0){
    		 // 새로운 다이얼로그 창 띄우기
    		 $(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다.");    		 
    	 }
    	 $("#myModal").modal("show");
     }
     function goMsg(){
    	 alert("삭제된 게시물입니다."); // Modal창
     }
  </script>
</head>
<body>
<jsp:include page="../common/header.jsp"/> 
<div class="container listCt" >
  <div class="card">
    <div class="card-header" >
       <c:if test="${empty mvo}">
	     <form class="form-inline" action="${cpath}/login/loginProcess" method="post">
		  <div class="form-group">
		    <label for="memID">ID:</label>
		    <input type="text" class="form-control" name="memID">
		  </div>
		  <div class="form-group">
		    <label for="memPwd">Password:</label>
		    <input type="password" class="form-control" name="memPwd">
		  </div>
		  <button type="submit" class="btn btn-default">로그인</button>
		 </form>
		</c:if>
		<c:if test="${!empty mvo}">
		 <form class="form-inline" action="${cpath}/login/logoutProcess" method="post">
		  <div class="form-group">
		    <label>${mvo.memName}님 방문을 환영합니다.</label>		    
		  </div>
		  <button type="submit" class="btn btn-default">로그아웃</button>
		 </form>
	   </c:if>
    </div>
    <div class="card-body">
      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <c:forEach var="vo" items="${list}">
          <tr>
            <td>${vo.idx}</td>           
            <td>
            <c:if test="${vo.boardLevel>0}">
              <c:forEach begin="1" end="${vo.boardLevel}">
                 <span style="padding-left: 10px"></span>
              </c:forEach>            
            </c:if>
            <c:if test="${vo.boardLevel>0}">
              <c:if test="${vo.boardAvailable==1}">
               <a class="move" href="${vo.idx}"><c:out value='[RE]${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
               <a href="javascript:goMsg()">[RE]삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            <c:if test="${vo.boardLevel==0}">
              <c:if test="${vo.boardAvailable==1}">
                <a class="move" href="${vo.idx}"><c:out value='${vo.title}'/></a>
              </c:if>
              <c:if test="${vo.boardAvailable==0}">
                <a href="javascript:goMsg()">삭제된 게시물입니다.</a>
              </c:if>
            </c:if>
            </td>
            <td>${vo.writer}</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>
            <td>${vo.count}</td>
          </tr>
        </c:forEach>
        <c:if test="${!empty mvo}"> 
        <tr>
          <td colspan="5">
            <button id="regBtn" class="btn btn-sm btn-primary float-right">글쓰기</button>            
          </td>
        </tr>
        </c:if>
      </table>
      
      <!-- 페이징 START -->
	  <div style="text-align: center">     
	     <nav aria-label="Page navigation example">
		    <ul class="pagination">
		      <!-- 이전처리 -->
		      <li class="page-item">
		        <a class="page-link" href="#" aria-label="Previous">
		          <span aria-hidden="true">&laquo;</span>
		        </a>
		      </li>
		      
		      <!-- 페이지번호 처리 -->
		       <c:forEach var="pageNum" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	             <li class="page-item ${pageMaker.cri.page==pageNum ? 'active' : ''}"><a class="page-link" href="${pageNum}">${pageNum}</a></li>
		       </c:forEach> 
		       
		      <!-- 다음처리 -->
		      <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		          <span aria-hidden="true">&raquo;</span>
		      </a>
		      </li>
		    </ul>
	     </nav>
	  </div>
      
       <!-- 검색메뉴 -->
       <div style="text-align: center;">
		<form class="form-inline" action="${cpath}/board/list" method="post">
		  <div class="form-group">	
		   <select name="type" class="form-control">
		      <option value="writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''}>이름</option>
		      <option value="title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
		      <option value="content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
		   </select>
		  </div>
		  <div class="form-group">	
		    <input type="text" class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
		  </div>
		  <button type="submit" class="btn btn-success">검색</button>
		</form>
	   </div>
      
      <form id="pageFrm" action="${cpath}/board/list" method="post">
         <!-- 게시물 번호(idx)추가 -->         
         <input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/>
         <input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
         <input type="hidden" name="type" value="${pageMaker.cri.type}"/>
         <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/>
      </form>      
      
    </div>
  </div>
</div>

  
<footer>
   <jsp:include page="../common/footer.jsp"></jsp:include>
</footer>
  <!--  다이얼로그창(모달) -->
	<!-- Modal -->
	 <div class="modal" id="myModal">
	  <div class="modal-dialog">
	    <div id="checkType" class="modal-content">
	
	      <!-- Modal Header -->
	      <div  class="modal-header panel-heading">
	        <h4 class="modal-title">메시지 확인</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Modal END-->
</body>
</html>