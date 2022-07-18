<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/includes/tags.jsp" %>
<%@ include file="/resources/includes/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/resources/includes/jqueryandcsrf.jsp"/>
<title>Insert title here</title>
</head>

<style>
.gradient-custom {
background: #FFE6E6;
}
.card-registration .select-input.form-control[readonly]:not([disabled]) {
font-size: 1rem;
line-height: 2.15;
padding-left: .75em;
padding-right: .75em;
}
.card-registration .select-arrow {
top: 13px;
}
.title{
text-align: center;
}
</style>
<body>


	<section class="vh-100 gradient-custom">
    <div class="row justify-content-center align-items-center h-100">
	<c:choose>
		<c:when test="${message != null}">
			<h3 class="title">${message}</h3>
		</c:when>
		<c:otherwise>
			<h3 class="title">새로운 패스워드를 등록해주세요</h3>
		</c:otherwise>
	</c:choose>
      <div class="col-12 col-lg-9 col-xl-7">
        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
          <div class="card-body p-4 p-md-5">
            <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">비밀번호 변경</h3>
            
            <form class="newPasswordForm" data-key="<c:out value='${key}'/>">

 
              <div class="row">
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                    <label class="form-label">패스워드</label>
                    <input type="password" name="password" maxlength="30" class="form-control form-control-lg" />
                  </div>
                </div>
                </div>
                
               <div>
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                  	<label class="form-label">패스워드 확인</label>
                    <input type="password" name="passwordCheck" maxlength="30" class="form-control form-control-lg" />
                  </div>
                </div>
              </div>
              
              <div class="mt-213 pt-1023">
                <input class="btn btn-primary btn-lg" type="submit" value="Submit" id="newPassword"/>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</section>
	<%@ include file="/resources/includes/footer.jsp" %>
	<script type="text/javascript" src="/resources/js/newpassword.js"></script> 
</body>
</html>