<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/includes/tags.jsp" %>
<%@ include file="includes/header.jsp" %>
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
            	<h1>맛있는 레시피</h1>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	<c:forEach items="${food}" var="foods">
                		<div class="col mb-5">
                        	<div class="card h-100">
                        	<input class="recipeid" style="display:none;" value="${foods.RECIPEID}" />
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
        
        
        <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">알림</h4>
                    </div>
                    <div class="modal-body"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="ok">확인</button>
                    </div>
                </div>
            </div>
        </div>
        
        <nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center" id ="page" data-amount="${page.unit.amount}">
		    <c:if test="${page.prev}">
               <li class="page-item"><a class="page-link" href="${page.startPage -1}">previous</a></li>
            </c:if>
		    <c:forEach var="num" begin="${page.startPage}" end="${page.endPage }">
               <li class="page-item ${page.unit.page == num ? 'active':''}">
               <a class="page-link" href="${num }">${num }</a>
            </c:forEach>
		    <c:if test="${page.next}">
              <li class="page-item"><a class="page-link" href="${page.endPage +1}">next</a></li>
            </c:if>
		  </ul>
		</nav>
		
         <script type="text/javascript">
			$(document).ready(function(e){
				
				$(".page-link").on("click",function(e){
					
					 e.preventDefault();
					
					 const pageForm = $('<form></form>');
			    	 const page = $(this).attr("href");
					 const amount = $("#page").data("amount");
			    
			    	 pageForm.attr("action", "main");
			    	 pageForm.attr("method", "get");
			    	 pageForm.append($('<input/>', {type: 'hidden', name: 'page', value: page}));
			    	 pageForm.append($('<input/>', {type: 'hidden', name: 'amount', value: amount}));
			    	 pageForm.appendTo('body');
			    	 pageForm.submit();
					
				})
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
					console.log(btn.parents('div').eq(3));
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
								btn.attr("style", "background-color:white;");
						},
						error: function(error){
							console.log(error);
						}
					})
				})
			})
		</script>
        
        <script type="text/javascript">
        	$(document).ready(function(e){
        		var form = $("#form");
            	$('a.btn-recipe').on('click', function(e){
            		e.preventDefault();
                	form.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
                	form.submit();
            	})
        		function modalCheck(result){
        			if(result === "") return;
        			if(result === "success") $('.modal-body').html("수정되었습니다. 수정하신 이메일로 인증링크를 발송했습니다.");
        			else $('.modal-body').html("에러가 발생했습니다.");
        			$('#Modal').modal("show");
        		}
        		
        		$('button[id="ok"]').on("click", function(e){
        			$('#Modal').modal("hide");
        		})
        		
        		var result = '<c:out value="${result}"/>';
        		modalCheck(result);
        	})
        </script>
     
		<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>