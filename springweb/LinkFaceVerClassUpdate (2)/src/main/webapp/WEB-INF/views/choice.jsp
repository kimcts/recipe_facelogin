<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="includes/header.jsp" %>
<div>
		<form action="/choice" method="post">
			재료입력: <input type="text" name="foodingredients" required="required">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<button type="submit">등록</button>
		</form>
</div>
<div class="">

</div>

		
<%@ include file="includes/footer.jsp" %>