<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=133293f1913c5a99ebacd5c899673ffe"></script>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
  <link href="${contextPath}/resources/css/font.css" rel="stylesheet">
  <link href="${contextPath}/resources/css/image.css" rel="stylesheet">
  <script type="text/javascript">
    $(document).ready(function(){
    	if(${!empty msgType}){
    		$("#myMessage").modal("show");
    	}
    	
    	var pageFrm=$("#pageFrm");
    	$(".move").on("click", function(e){
    		e.preventDefault();
    		var idx=$(this).attr("href");
    		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
    		pageFrm.append(tag);
    		pageFrm.attr("action","${contextPath}/board/get.do");
    		pageFrm.attr("method", "get");
    		pageFrm.submit();
    	});
    	
    	// 책 검색 버튼이 클릭 되었을때 처리
      	$("#search").click(function(){
      		var bookname=$("#bookname").val();
      		if(bookname==""){
      			alert("책 제목을 입력하세요");
      			return false;
      		}
      		// Kakao 책 검색 openAPI를 연동(키를발급)
      		$.ajax({
      			url : "https://dapi.kakao.com/v3/search/book?target=title",
      			headers : {"Authorization": "KakaoAK 279534ec8584453f1bdfbfdc19962134"},
      			type : "get",
      			data : {"query" : bookname},
      			dataType : "json",
      			success : bookPrint,
      			error : function(){ alert("error");}	
      		});
      		$(document).ajaxStart(function(){ $(".loading-progress").show(); });
      		$(document).ajaxStop(function(){ $(".loading-progress").hide(); });
      	});   
    	
      
      	// 지도 mapBtn 클릭시 지도가 보이도록 하기
      	$("#mapBtn").click(function(){
      		var address=$("#address").val();
      		if(address==''){
      			alert("주소를 입력하세요");
      			return false;
      		}
      		$.ajax({
      			url : "https://dapi.kakao.com/v2/local/search/address.json",
      			headers : {"Authorization": "KakaoAK 279534ec8584453f1bdfbfdc19962134"},
      			type : "get",
      			data : {"query" : address},
      			dataType : "json",
      			success : mapView,
      			error : function() { alert("error"); }  			
      		});
      	});
       });
      
       function bookPrint(data){
      	 var bList="<table class='table table-hover'>";
      	 bList+="<thead>";
      	 bList+="<tr>";
      	 bList+="<th>책이미지</th>";
      	 bList+="<th>책가격</th>";
      	 bList+="</tr>";
      	 bList+="</thead>";
      	 bList+="<tbody>";
      	 $.each(data.documents,function(index, obj){
      		 var image=obj.thumbnail;
      		 var price=obj.price;
      		 var url=obj.url;
      		 bList+="<tr>";
          	 bList+="<td><a href='"+url+"'><img src='"+image+"' width='50px' height='60px'/></a></td>";
          	 bList+="<td>"+price+"</td>";
          	 bList+="</tr>";
      	 }); 
      	 bList+="</tbody>";
      	 bList+="</table>";
      	 $("#bookList").html(bList);
       }
       function mapView(data){
    		 var x=data.documents[0].x; // 경도
    		 var y=data.documents[0].y; // 위도
    	  	 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	  	    mapOption = { 
    	  	        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
    	  	        level: 2 // 지도의 확대 레벨
    	  	    };
    	  	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    	  	var map = new kakao.maps.Map(mapContainer, mapOption); 
    	  	
    	  	// 마커가 표시될 위치입니다 
    	  	var markerPosition  = new kakao.maps.LatLng(y, x); 

    	  	// 마커를 생성합니다
    	  	var marker = new kakao.maps.Marker({
    	  	    position: markerPosition
    	  	});
    	     
    	  	// 마커가 지도 위에 표시되도록 설정합니다
    	  	marker.setMap(map);
    	  	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
    	  	var iwContent = '<div style="padding:5px;">Hello World!</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    	  	    

    	  	// 인포윈도우를 생성합니다
    	  	var infowindow = new kakao.maps.InfoWindow({
    	  	    content : iwContent
    	  	});

    	  	// 마커에 클릭이벤트를 등록합니다
    	  	kakao.maps.event.addListener(marker, 'click', function() {
    	  	      // 마커 위에 인포윈도우를 표시합니다
    	  	      infowindow.open(map, marker);  
    	  	});
    	   }
  </script>
</head>
<body>
<header>
  <jsp:include page="../common/header.jsp"/>
</header>
<div class="card">
	<div class="visual">
	  <img alt="img" src="${contextPath}/resources/images/bg.jpg" class="image"/>
	  <div class="vsTitle">
	    <h1 class="jua-regular mainTitle">MyHome</h1>
	    <p class="jua-regular subTitle">Spring, mybatis(HicariCP), JSP, jQuery, ajax,  jstl, SpringSecurity 사용</p>
	  </div>
	</div>
  	<div class="card-body">
      <div class="row">
        <div class="col-lg-2">
		    <jsp:include page="left.jsp"/>
		</div>
        <div class="col-lg-7">
           <div class="card" style="min-height:500px; max-height: 1000px">
             <div class="card-body">
             <h1 class="jua-regular">최신글</h1>
               <table class="table table-hover">
                 <thead>
                   <th>번호</th>
                   <th>제목</th>
                   <th>작성일</th>
                 </thead>
                 <tbody>
                  <c:forEach var="vo" items="${list}">
                    <c:if test="${vo.boardLevel==0}">
                      <c:if test="${vo.boardAvailable==1}">
		                <tr>
		                  <td>${vo.idx}</td>
		                  	<td>
				               <a class="move" href="${vo.idx}"><c:out value='${vo.title}'/></a>
		                  	</td>
		                  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate}"/></td>
		                </tr>
	                  </c:if>
	                </c:if>
                  </c:forEach>
                 </tbody>
               </table>
             </div>
           </div>
        </div>
        
        <div class="col-lg-3">
           <jsp:include page="right.jsp"/>
        </div>
         
        <form id="pageFrm" >
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
  
  <!-- Modal -->
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
</body>
</html>