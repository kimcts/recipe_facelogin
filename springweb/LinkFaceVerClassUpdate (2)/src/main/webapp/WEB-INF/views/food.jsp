<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ include file="/resources/includes/tags.jsp" %>
		<%@ include file="/resources/includes/header.jsp" %>
		<link rel="stylesheet" href="/resources/css/star.css">
		<style>
		.smallstar {
		    position: relative;
		    font-size: 1.0rem;
		    color: yellow;
		}
		</style>
<jsp:include page="/resources/includes/jqueryandcsrf.jsp"/>
		<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xs-9 justify-content-center">
               		<div class="col mb-5">
                       	<div class="card h-100">
                            <img class="card-img-top" src="${food.IMGURL}" alt="..." />
                            <div class="card-body p-4">
   	                            <div class="text-center">
                                    <h5 class="fw-bolder">${food.RECIPENMKO}</h5>
                                </div>
   	                        </div>
           	            </div>
               	    </div>
                </div>
                <div>
                    <div class="card-body p-4">
                        <div class="text-center">
                            <h5 class="fw-bolder">${food.SUMRY}</h5>
                        </div>
                    </div>
   	            </div>
        	</div>
        </section>
        
        <section class="py-5">
        	<h1 style="text-align:center;">[ 필수 재료 ]</h1>
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-2">
                	<c:forEach items="${ingredients}" var="ingredients">
                		<div class="col mb-3" style="padding-left:10%;">
                        	<div class="card w-75 h-100" style="justify-content:center;">
	                            <div class="card-body p-4">
			                        <div class="text-center">
			                            <h5 class="fw-bolder">${ingredients.IRDNTNM} ( ${ingredients.IRDNTCPCTY} ) </h5>
			                        </div>
			                    </div>
            	            </div>
                	    </div>
					</c:forEach>
                </div>
            </div>
        </section>
        
        <section class="py-5">
        	<h1 style="text-align:center;">[ 조리 순서 ]</h1>
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-1">
                	<c:forEach items="${order}" var="orders">
                		<div class="col mb-3">
                        	<div class="card w-100 h-100" style="justify-content:center;">
	                            <div class="card-body p-4">
			                        <div class="text-center">
			                            <h5 class="fw-bolder">( ${orders.COOKINGNO} ) ${orders.COOKINGDC}</h5>
			                        </div>
			                    </div>
            	            </div>
                	    </div>
					</c:forEach>
                </div>
            </div>
        </section>
<sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_MANAGER','ROLE_ADMIN')">
           <div class="container">
             <div class="row align-items-center vh-100">
                 <div class="col-6 mx-auto">
                     <div class="card shadow border">
                         <div class="card-body d-flex flex-column align-items-center">
                            <h2>별점 등록</h2>               
                         <span class="star"></span>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
      </sec:authorize>
    
<script>
$(document).ready(function(){
	  let selectStar = "☆☆☆☆☆";
	   let selectGrade = 0;
	   let star = "";
	   let grade = 0;
	   let message = "";
	   
	   $(".star").html(selectStar);
	   
	   $(".star").on("mousemove",function(e){
	      let x = e.pageX - $(this).offset().left;
	      grade = x / 24;
	      for(i = 0; i < 5; i++){
	         if(grade >= 0.1){
	            star += "★";
	            grade -= 1;
	         }
	         else{ star += "☆"; }
	      }
	      $(".star").html(star);
	      star = "";
	   })

	   $(".star").on("mouseout",function(e){
	      $(".star").html(selectStar);
	   })

	   $(".star").on("click",function(e){
	      let x = e.pageX - $(this).offset().left;
	      grade = x / 24;
	      selectGrade = Math.ceil(grade);
	      for(i = 0; i < 5; i++){
	         if(grade > 0.1){
	            star += "★";
	            grade -= 1;
	         }   
	         else{ star += "☆"; }
	      }
	      selectStar = star;
	      star = "";
		if(selectGrade <= 0){
			message = "등록하신 평점을 삭제하시겠습니까?"
					
		}
		else{
			message = selectGrade + " / 5 이대로 별점을 등록하시겠습니까?";	
		}
		
		if(confirm(message)) {
			let i = ${food.RECIPEID};
			console.log(i);
			
			let recipeGrade = {
				recipeid : ${food.RECIPEID},
				grade : selectGrade	
			}
			
			$.ajax({
			    url: '/recipegrade',
			    type: 'post',
			    data : JSON.stringify(recipeGrade),
				contentType : "application/json; charset=UTF-8",
				beforeSend : function(xmlHttpRequest){   
					xmlHttpRequest.setRequestHeader(csrfHeader,
							csrfToken);
	            },
			    success: function (data){
					alert(data);
			    },
			});
		}
		
	
			
			
	})
})
</script>
        
        
        
		<%@ include file="/resources/includes/footer.jsp" %>