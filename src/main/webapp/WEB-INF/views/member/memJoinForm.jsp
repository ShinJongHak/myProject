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
    function registerCheck(){
       var memID=$("#memID").val();
       $.ajax({
    	   url : "${contextPath}/member/memRegisterCheck.do",
    	   type : "get",
    	   data : { "memID" : memID},
    	   success : function(result){
    		   if(result==1){
    			  $("#checkMessage").html("사용할 수 있는 아이디입니다.");
    		   }else{
    			  $("#checkMessage").html("사용할 수 없는 아이디입니다."); 
    		   }
    		   $("#myModal").modal("show");
    	   },    	   
    	   error : function(){ alert("error"); }    	   
       });    	
    }  
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
    function goInsert(list){
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
   <div class="card-header">회원가입</div>
   <div class="card-body">
     <form name="frm" action="${contextPath}/member/memRegister.do" method="post">
         <input type="hidden" id="memPassword" name="memPassword" value=""/>
         <input type="hidden"name="${_csrf.parameterName}" value="${_csrf.token}"/>
         <table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
           <tr>
             <td style="width: 110px; vertical-align: middle;">아이디</td>
             <td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요."/></td>
             <td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td>
           </tr>
           <tr>
             <td style="width: 110px; vertical-align: middle;">비밀번호</td>
             <td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>            
           </tr>
           <tr>
             <td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
             <td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 확인하세요."/></td>            
           </tr>
            <tr>
             <td style="width: 110px; vertical-align: middle;">사용자 이름</td>
             <td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요."/></td>            
           </tr>
           <tr>
             <td style="width: 110px; vertical-align: middle;">나이</td>
             <td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요."/></td>            
           </tr>
           <tr>
             <td style="width: 110px; vertical-align: middle;">성별</td>
             <td colspan="2">
                <div class="form-group" style="text-align: center; margin: 0 auto;">
                    <div class="btn-group" data-toggle="buttons">
                       <label class="btn btn-primary active">
                         <input type="radio"  name="memGender" autocomplete="off" value="남자" checked/>남자
                       </label>
                        <label class="btn btn-primary">
                         <input type="radio"  name="memGender" autocomplete="off" value="여자"/>여자
                       </label>
                    </div>                    
                </div>
             </td>            
           </tr> 
           
           <tr>
             <td style="width: 110px; vertical-align: middle;">이메일</td>
             <td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="text" maxlength="20" placeholder="이메일을 입력하세요."/></td>            
           </tr>
           
           <tr>
             <td style="width: 110px; vertical-align: middle;">사용자 권한</td>
             <td colspan="2">
                <input type="checkbox" name="authList[0].auth" value="ROLE_USER"> ROLE_USER
	            <input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER"> ROLE_MANAGER
	            <input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN"> ROLE_ADMIN           
           </tr> 
           
           <tr>
             <td colspan="3" style="text-align: left;">
                <span id="passMessage" style="color: red"></span><input type="button" class="btn btn-primary btn-sm float-right" value="등록" onclick="goInsert()"/>
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