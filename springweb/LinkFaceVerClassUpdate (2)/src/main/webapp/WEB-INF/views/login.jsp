<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테스트 페이지</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="icon" type="image/x-icon" href="resources/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="resources/css/styles.css" rel="stylesheet" />
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://recipe1.ezmember.co.kr/static/css/font_20210621.css" />
	<link rel="stylesheet" type="text/css" href="https://recipe1.ezmember.co.kr/static/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="https://recipe1.ezmember.co.kr/static/css/ez_recipe_20220407.css" />
	<script src="resources/js/scripts.js"></script> 
	
</head>
<body>
	<!-- nav -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">간편한 레시피</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="/main">Home</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Recipe</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/homepage">All Foods</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="/jjim">찜목록</a></li>
                                <li><a class="dropdown-item" href="/chuchun">추천목록</a></li>
                            </ul>
                        </li>
                    </ul>   
                </div>
            </div>
        </nav>
        
        
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">맛있는 레시피</h1>
                    <p class="lead fw-normal text-white-50 mb-0">안녕하세요</p>
                </div>
            </div>
            
        </header>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="resources/js/scripts.js"></script>
<div class="container_etc" style="width:460px;">
    <h2>로그인 / 회원가입</h2>
    <div class="panel-body">
        <form name="form_login" id="formLogin" method="post" action="/login" autocomplete="off">
            <div class="form_login_in" style="padding-right:22px;">
                <input type="text" name="username" class="" id="username" placeholder="아이디">
                <span id="idMsg" style="display:none; color:#FF0000;">아이디를 입력해주세요.</span>
            </div>
            <div class="form_login_in">
                <input type="password" name="password" class="" id="password" placeholder="비밀번호">
                <span id="pwMsg" style="display:none;color:#FF0000;">비밀번호를 입력해주세요.</span>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="login_perma" value="1"><span class="guide_txt">로그인 상태 유지</span>
                </label>
            </div>
            <div>
            	<label>
            		<a type="button" href="http://127.0.0.1:3000/">얼굴인식 로그인</a>
            	</label>
            </div>
			<div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</div>
            <div class="form_login_btn">
                <button type="submit">로그인</button>
            </div>
        </form>
            <div class="join_btn3">
            	<a class="btn_signUp" type="button" onClick="location.href='/signup'">회원가입</a>
                <a class="btn_find" type="button">아이디/비밀번호 찾기</a>
            </div>
            
    </div>




</div>
<div class="modal fade" tabindex="-1" id="modal" aria-labelledby="modal">
	<div class="modal-dialog">
	    <div class="modal-content">
	    	<div class="modal-header">
	    		<h5 class="modal-title" id="modallabel">아이디/패스워드 찾기</h5>
	    	</div>
	    	<div class="modal-body">
	        	<div class="menu">
	        		<button class="btn btn-info btn_findid">아이디 찾기</button>
	          		<button class="btn btn-info btn_findpassword">비밀번호 찾기</button>  
	        	</div>
		        <div class="findid">
		         <h4>아이디 찾기</h4>
		         <p>사용자명과 이메일을 입력해주세요</P>
		           <form class="findid_form" data-type="id">
		            <div class="form-floating mb-3">
		               <label for="name">이름</label>
		               <input class="form-control rounded-3" type="text" name="name" maxlength="30">
		            </div>
		            <div class="form-floating mb-3">
		               <label for="email">이메일</label>
		               <input class="form-control rounded-3" type="email" name="email" maxlength="30">
		            </div>
		            <button class="btn btn-primary submit findid">제출</button>
		         </form>
		        </div>
		        <div class="findpassword">
		           <h4>비밀번호 찾기</h4>
		         <p>ID 사용자명 이메일을 입력해주세요</P>
		           <form class="findpassword_form " data-type="password">
		            <div class="form-floating mb-3">
		               <label for='id'>아이디</label>
		               <input class="form-control rounded-3" type="text" name="id" maxlength="30">
		            </div>
		            <div class="form-floating mb-3">
		               <label for="name">이름</label>
		               <input class="form-control rounded-3" type="text" name="name" maxlength="30">
		            </div>
		            <div class="form-floating mb-3">
		               <label for="email">이메일</label>
		               <input class="form-control rounded-3" type="email" name="email" maxlength="30">
		            </div>
		            <button class="btn btn-primary submit findpassword">제출</button>
		         </form>
		        </div>
	        <div class="modal_modal result">
	        </div>
	        </div>
	        <div class="modal-footer">
		        <button class="btn btn-danger btn_close">닫기</button>  
		        <button class="btn btn-dark btn_back">뒤로가기</button>
	        </div>
	    </div>
    </div>
   </div>
      <script>
       $(document).ready(function(){
    	   let csrfHeader = `${_csrf.headerName}`;
    	   let csrfToken = `${_csrf.token}`;
		   let dataInputCheck = true;
		   let regExp = 
           /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
     // 모달 띄우기
     $(".btn_find").click(function(){
    	$(".modal").find("input").val("");
    	$(".findid").hide();
    	$(".findpassword").hide();
    	$(".modal").modal("show");
      	$(".menu").show();
       	$(".modal").fadeIn();
       
      
     });
     // 닫기 버튼을 누를 경우
     $(".btn_close").click(function(){
       $(".modal").modal("hide");
      $(".modal_modal ").hide(); 
      $(".btn_back").hide();
     });
     // esc 를 누를 경우
     window.addEventListener("keyup", function(e){
       if($(".modal").css("display") === "block" && e.key === "Escape"){
          $(".modal").hide();
          $(".modal_modal ").hide();
          $(".btn_back").hide();
       }
      });
      // 뒤로가기
     $(".btn_back").click(function(){
        $(".modal_modal ").hide();
        $(".menu").show();
        $(this).hide();
        $(".modal_modal result").hide();
        $(".modal input").val("");
        $(".findpassword").hide();
        $(".findid").hide();
      
     });
     // 아이디 찾기
     $(".btn_findid").click(function(){
    	$(".menu").hide();
        $(".findid").show();
        $(".btn_back").show();
        $(".findpassword").hide();
     });
     // 비밀번호 찾기
     $(".btn_findpassword").click(function(){
    	$(".menu").hide();
    	$(".findid").hide();
    	$(".findpassword").show();
        $(".btn_back").show();
     });
     
     
     $(".submit").on("click",function(e){
      
      e.preventDefault();
      
      
      $(this).siblings("div").children("input").each(function(){
         if($(this).val().trim() == ''){
            alert("사용자 데이터 입력 필수");
                dataInputCheck = false;
             }
      })
        if(!dataInputCheck){
         alert("사용자 데이터 입력 필수");
         dataInputCheck = true;
         return;
      }
      else if($(this).siblings("div").children("input[name='email']").val().match(regExp) == null){
         alert("올바른 이메일 형식이 아닙니다");
         return;
      }
      // 동적으로 객체 생성
      let type =  $(this).parent("form").data("type");
      let checkUser = {};
      $(this).siblings("div").children("input").each(function(){
         checkUser[$(this).attr("name")] = $(this).val();
      })
      
      $.ajax({
          url: '/find',
          type: 'post',
          data : JSON.stringify({[type] :checkUser}),
         contentType : "application/json; charset=UTF-8",
         beforeSend : function(xmlHttpRequest){   
            xmlHttpRequest.setRequestHeader(csrfHeader,
                  csrfToken);
            },
          success: function (data){
            $(".result").html(data);
            $(".result").show();
          },
          error: function (error){
            $(".result").html(error);
            $(".result").show();
          }
      });
      
      
   })
       })
   </script>
<%@ include file="/resources/includes/footer.jsp" %>