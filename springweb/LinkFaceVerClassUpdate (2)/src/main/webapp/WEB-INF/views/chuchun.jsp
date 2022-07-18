<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="includes/header.jsp" %>
	<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
            	<h1>찜목록과 비슷한 메뉴</h1>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	<c:forEach items="${chuchun1}" var="foods">
                		<div class="col mb-5">
                        	<div class="card h-100">
                        	<input type="hidden" name="recipeId" value="${foods.RECIPEID}" />
	                            <img class="card-img-top" src="${foods.IMGURL}" alt="..." />
	                            <div class="card-body p-4">
    	                            <div class="text-center">
	                                    <h5 class="fw-bolder">${foods.RECIPENMKO}</h5>
	                                </div>
    	                        </div>
	                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
    	                            <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">보러가기</a>
    	                                	                       <sec:authorize access="isAuthenticated()">
    	                            		<c:set var="jjim_flag" value="false" />
    	                            		<c:forEach items="${jjim}" var="jjims">
    	                            			<c:if test="${not jjim_flag}">
	   	                            				<c:if test="${jjims.jjim eq foods.RECIPEID}">
	   	                            					<c:set var="jjim_flag" value="true" />    	                            					
	   	                            				</c:if>
   	                            				</c:if>
    	                            		</c:forEach>
    	                            		<c:if test="${jjim_flag}">
    	                            			<button name="jjimbtn" class="btn btn-outline-dark mt-auto" style="background-color:red;">찜</button>
    	                            		</c:if>
    	                            		<c:if test="${not jjim_flag}">
    	                            			<button name="jjimbtn" class="btn btn-outline-dark mt-auto" >찜</button>
    	                            		</c:if>
    	                            		<div id="userkey" style="display:none;"><sec:authentication property="principal.userInfo.userKey"/></div>
    	                            	</sec:authorize> 
    	                            </div>
        	                    </div>
            	            </div>
                	    </div>
					</c:forEach>
					
                </div>
            </div>
        </section>
        
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
            	<h1>가지고있는 재료로 만들 수 있는 메뉴 </h1>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	<c:forEach items="${chuchun2}" var="foods">
                		<div class="col mb-5">
                        	<div class="card h-100">
                        	<input type="hidden" name="recipeId" value="${foods.RECIPEID}" />
	                            <img class="card-img-top" src="${foods.IMGURL}" alt="..." />
	                            <div class="card-body p-4">
    	                            <div class="text-center">
	                                    <h5 class="fw-bolder">${foods.RECIPENMKO}</h5>
	                                </div>
    	                        </div>
	                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
    	                            <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">보러가기</a>
    	                       <sec:authorize access="isAuthenticated()">
    	                            		<c:set var="jjim_flag" value="false" />
    	                            		<c:forEach items="${jjim}" var="jjims">
    	                            			<c:if test="${not jjim_flag}">
	   	                            				<c:if test="${jjims.jjim eq foods.RECIPEID}">
	   	                            					<c:set var="jjim_flag" value="true" />    	                            					
	   	                            				</c:if>
   	                            				</c:if>
    	                            		</c:forEach>
    	                            		<c:if test="${jjim_flag}">
    	                            			<button name="jjimbtn" class="btn btn-outline-dark mt-auto" style="background-color:red;">찜</button>
    	                            		</c:if>
    	                            		<c:if test="${not jjim_flag}">
    	                            			<button name="jjimbtn" class="btn btn-outline-dark mt-auto" >찜</button>
    	                            		</c:if>
    	                            		<div id="userkey" style="display:none;"><sec:authentication property="principal.userInfo.userKey"/></div>
    	                            	</sec:authorize> 
    	                            </div>
        	                    </div>
            	            </div>
                	    </div>
					</c:forEach>
					
                </div>
            </div>
        </section>
        					<script>
					$(document).ready(function(){
		        		var form = $("#form");
		            	$('a.btn-recipe').on('click', function(e){
		            		e.preventDefault();
		                	form.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
		                	form.submit();
		            	})
						$('button[name=jjimbtn]').on("click", function(e){
							var btn = $(this);
							var csrfHeader = `${_csrf.headerName}`;
							var csrfToken = `${_csrf.token}`;
							console.log(btn.parents('div').eq(2).children('input.recipeid'));
							var recipeid = btn.parents('div').eq(2).children('input.recipeid').val();
							var userkey = $('div#userkey').html();
							var data = { userKey: userkey, jjim : recipeid , foodingredients: null};
							console.log(data);
							
							$.ajax({
								url: '/wishlist',
								type: 'POST',
								data: JSON.stringify(data),
								contentType: 'application/json; charset=utf-8',
								beforeSend : function(xmlHttpRequest){
								      xmlHttpRequest.setRequestHeader(csrfHeader,csrfToken);
								},
								success: function(data){
									if(data === 'insert')
										btn.attr("style", "background-color:red;");
									else
										btn.parents('div').eq(2).remove();
										btn.attr("style", "background-color:white;");
										
								},
								error: function(error){
									console.log(error);
								}
							})
						})
					})
					</script>
<%@ include file="includes/footer.jsp" %>