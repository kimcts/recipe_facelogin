<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ include file="/resources/includes/header.jsp" %>
		<link rel="stylesheet" href="/resources/css/star.css">
		<style>
		.smallstar {
		    position: relative;
		    font-size: 1.0rem;
		    color: yellow;
		}
		</style>
		<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	
                	<c:forEach items="${food}" var="foods">
                		<div class="col mb-5">
                        	<div class="card h-100">
	                            <img class="card-img-top" src="${foods.IMGURL}" alt="..." />
	                            <div class="card-body p-4">
    	                            <div class="text-center">
	                                    <h5 class="fw-bolder">${foods.RECIPENMKO}</h5>
	                                </div>
    	                        </div>
	                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                            	<small>조회수: ${foods.viewsCount}</small><br>
	                            	 <c:choose>
									   <c:when test="${foods.GRADEAVG != 0 }">
									  		<small class="star">★</small><small>${foods.GRADEAVG} / 5.0 (${foods.GRADECOUNT})</small>
									   </c:when>
									   <c:otherwise>
									   		<small>등록된 별점이 없습니다</small>
									   </c:otherwise>
									</c:choose>
    	                               <div class="text-center">
    	                            	<a class="btn btn-outline-dark mt-auto btn-recipe" href="${foods.RECIPEID}">보러가기</a>
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
					
					<form id="form" action="/food" method="get"></form>
                
                </div>
            </div>
        </section>
        
        <script type="text/javascript">
        	$(document).ready(function(){
        		var form = $("#form");
            	$('a.btn-recipe').on('click', function(e){
            		e.preventDefault();
                	form.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
                	form.submit();
            	})
        	})
        </script>
		
		<%@ include file="/resources/includes/footer.jsp" %>