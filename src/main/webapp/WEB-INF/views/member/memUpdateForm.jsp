<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 

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
 <script type="text/javascript">
    $(document).ready(function(){
    	if(${!empty msgType}){
     		$("#messageType").attr("class", "modal-content panel-warning");    
    		$("#myMessage").modal("show");
    	}
    });
 
    function passwordCheck(){
    	var memPassword1=$("#memPassword1").val();
    	var memPassword2=$("#memPassword2").val();
    	if(memPassword1 != memPassword2){
    		$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
    	}else{
    		$("#passMessage").html("");
    		$("#memPassword").val(memPassword1);
    	}   	
    }
    function goUpdate(){
    	var memAge=$("#memAge").val();
    	if(memAge==null || memAge=="" || memAge==0){
    		alert("나이를 입력하세요");
    		return false;
    	}
    	document.frm.submit(); // 전송
    }
  </script>
</head>
<body>
<header>
  <jsp:include page="../common/header.jsp"/>
</header>
<div class="container">
  <div class="card">
    <div class="card-header">회원정보수정</div>
    <div class="card-body">
      <form name="frm" action="${contextPath}/member/memUpdate.do" method="post">
         <input type="hidden" id="memID" name="memID" value="${mvo.member.memID}"/>
         <input type="hidden" id="memPassword" name="memPassword" value=""/>
         <input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
         <table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
           <tr>
             <td style="width: 130px; vertical-align: middle;">아이디</td>
             <td>${mvo.member.memID}</td>
           </tr>
           <tr>
             <td style="width: 130px; vertical-align: middle;">비밀번호</td>
             <td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>            
           </tr>
           <tr>
             <td style="width: 130px; vertical-align: middle;">비밀번호 확인</td>
             <td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 확인하세요."/></td>            
           </tr>
            <tr>
             <td style="width: 130px; vertical-align: middle;">사용자 이름</td>
             <td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요." value="${mvo.memName}"/></td>            
           </tr>
           <tr>
             <td style="width: 130px; vertical-align: middle;">나이</td>
             <td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요." value="${mvo.memAge}"/></td>            
           </tr>
           <tr>
             <td style="width: 130px; vertical-align: middle;">성별</td>
             <td colspan="2">
                <div class="form-group" style="text-align: center; margin: 0 auto;">
                    <div class="btn-group" data-toggle="buttons">
                       <label class="btn btn-primary <c:if test="${mvo.member.memGender eq '남자'}"> active</c:if>">
                         <input type="radio"  name="memGender" autocomplete="off" value="남자" 
                           <c:if test="${mvo.member.memGender eq '남자'}"> checked</c:if> /> 남자
                       </label>
                        <label class="btn btn-primary <c:if test="${mvo.memGender eq '여자'}"> active</c:if>">
                         <input type="radio"  name="memGender" autocomplete="off" value="여자"
                           <c:if test="${mvo.member.memGender eq '여자'}"> checked</c:if> /> 여자
                       </label>
                    </div>                    
                </div>
             </td>            
           </tr> 
           <tr>
             <td style="width: 130px; vertical-align: middle;">이메일</td>
             <td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="text" maxlength="20" placeholder="이메일을 입력하세요." value="${mvo.memEmail}"/></td>            
           </tr>
           <tr>
             <td style="width: 130px; vertical-align: middle;">사용자 권한</td>
             <td colspan="2">
             <div class="btn-group" data-toggle="buttons">
               <label class="btn btn-outline-info">
                 <input type="checkbox" id="authList[0].auth" name="authList[0].auth" value="ROLE_USER" 
                  <c:forEach var="authVO" items="${mvo.member.authList}">
                    <c:if test="${authVO.auth eq 'ROLE_USER'}">
                      checked
                    </c:if> 
                  </c:forEach>
                 /> 
                 ROLE_USER 
               </label>
               <label class="btn btn-outline-info">
                 <input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER"
                   <c:forEach var="authVO" items="${mvo.member.authList}">
                    <c:if test="${authVO.auth eq 'ROLE_MANAGER'}">
                      checked
                    </c:if> 
                  </c:forEach>
                  /> 
                  ROLE_MANAGER
               </label>
               <label class="btn btn-outline-info">  
                 <input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN"
                   <c:forEach var="authVO" items="${mvo.member.authList}">
                     <c:if test="${authVO.auth eq 'ROLE_ADMIN'}">
                      checked
                     </c:if> 
                    </c:forEach>
                  />
                   ROLE_ADMIN  
               </label>   
             </div>        
             </td>    
           </tr>
           <tr>
             <td colspan="3" style="text-align: left;">
                <span id="passMessage" style="color: red"></span><input type="button" class="btn btn-primary btn-sm float-right" value="수정" onclick="goUpdate()"/>
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
</body>
</html>