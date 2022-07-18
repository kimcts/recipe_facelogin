<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/includes/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/includes/header.jsp" %>
<jsp:include page="/resources/includes/jqueryandcsrf.jsp"/>
<title>Insert title here</title>
</head>
<style>
.gradient-custom {
/* fallback for old browsers */
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
</style>
<body>

	<section class="vh-100 gradient-custom">
    <div class="row justify-content-center align-items-center h-100">
      <div class="col-12 col-lg-9 col-xl-7">
        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
          <div class="card-body p-4 p-md-5">
            <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">회원가입</h3>
            <form id="signup-form" action="signup" method="post">

              <div class="row">
                <div class="col-md-6 mb-4">
                  <div class="form-outline">
                    <label class="form-label">아이디</label>
                    <input type="text" class="form-control form-control-lg" name="id" maxlength="30"/>
                    <small id="id-check-result"></small>
                   </div>
                </div>
                 <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                  	<label class="form-label">아이디 중복체크</label><br>
                    <input class="btn btn-primary btn-dark" type="submit" value="Check" id="id-duplicate-check"/>
                  </div>
                </div>
              </div>

			<div class="row">
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                    <label class="form-label">이메일</label>
                    <input type="email" name="email" maxlength="30" class="form-control form-control-lg" />
                    <small id="email-check-result"></small>
                  </div>
                </div>
                
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                  	<label class="form-label">이메일 중복체크</label><br>
                    <input class="btn btn-primary btn-dark" type="submit" value="Check" id="email-duplicate-check"/>
                  </div>
                </div>
              </div>
	
              <div class="row">
                <div class="col-md-6 mb-4 d-flex align-items-center">
                  <div class="form-outline datepicker w-100">
                    <label class="form-label">이름</label>
                    <input type="text" name="name" maxlength="30" class="form-control form-control-lg" id="birthdayDate" />
                  </div>
                </div>
              </div>
              
              <div class="row">
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                    <label class="form-label">패스워드</label>
                    <input type="password" name="password" maxlength="30" class="form-control form-control-lg" />
                  </div>
                </div>
                
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                  	<label class="form-label">패스워드 확인</label>
                    <input type="password" name="passwordCheck" maxlength="30" class="form-control form-control-lg" />
                  </div>
                </div>
              </div>
              
              <div class="mt-213 pt-1023">
                <input class="btn btn-primary btn-lg" type="submit" value="Submit" id="signUp"/>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</section>

	
	<!-- 스크립트 -->
	<script type="text/javascript" src="/resources/js/signup.js"></script> 
	<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>