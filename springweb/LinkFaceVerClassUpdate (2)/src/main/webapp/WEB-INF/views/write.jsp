<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/includes/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/resources/includes/jqueryandcsrf.jsp"/>
<title>Admin</title>
</head>
<body>
	<form id="name">
		<div>
			<label>레시피 이미지</label>
			<input type="file" name="image"/>
			<div id="thumbnail">
			
			</div>
			<input name="SUMRY"/>
		</div>
		<div>
			<label>레시피명을 작성해주세요</label>
			<input name="RECIPENMKO"/>
		</div>
		<div>
			<label>레시피에 대해 설명해주세요</label>
			<textarea rows="5" cols="30" name="SUMRY">
			</textarea>
		</div>
		<div>
			<label>카테고리 (1)</label>
			<select name="NATIONNM">
				<option value="kor" selected>한식</option>
				<option value="jap">일식</option>
				<option value="chi">중식</option>
				<option value="wes">양식</option>
				<option value="wor">세계</option>
			</select>
		</div>
		<div>
			<label>카테고리 (2)</label>
			<input name="TYNM" placeholder="찜"/>
		</div>
		<div>
			<label>카테고리 (3)</label>
			<input name="IRDNTCODE" placeholder="쇠고기류"/> 
		</div>
		<div>
			<label>조리시간</label>
			<input name="COOKINGTIME"/> 분
		</div>
		<div>
			<label>칼로리</label>
			<input name="CALORIE"/> cal
		</div>
		<div>
			<label>몇인분의 음식인가요?</label>
			<input name="QNT"/>  인분
		</div>
		<div>
			<label>조리 난이도</label>
			<select name="NATIONNM">
				<option value="h" selected>상</option>
				<option value="m">중</option>
				<option value="r">하</option>
			</select>
		</div>
	</form>
	
	<form id="ingredients">
		<div>
			<label>재료</label>
			<input name="IRDNTNM"/>
		</div>
		<div>
			<label>단위</label>
			<input name="IRDNTCPCTY"/>
		</div>
		<div>
			<label>분류</label>
			<select name="IRDNTTYNM">
				<option value="3060001" selected>주재료</option>
				<option value="3060002">부재료</option>
				<option value="3060003">양념</option>
			</select>
		</div>
		<button id="click2">클릭</button>
	</form>
	
	<form id="order">
		<div>
			<label>내용</label>
			<textarea rows="5" cols="30" name="COOKINGDC"></textarea>
		</div>
		<div>
			<label>이미지</label>
			<div>
			이미지이미지
			</div>
			<input name="STRESTEPIMAGEURL"/>
		</div>
		<div>
			<label>팁</label>
			<input name="STEPTIP"/>
		</div>
		<button id="click">클릭</button>
	</form>
</body>
<div id="test">

</div>

<img src="\resources\2022\06\09\afa8fd8b-a0c7-45cd-b450-ac5066ae8a07_1PNG.PNG">
<img src="\resources\2022\06\09\197639dc-3617-461b-a562-6eaa40ded78b_4.PNG">
<img src="\resources\2022\06\09\b23d8462-7117-4ba1-9ee7-fb6d13b89511_3.PNG">
<script>

$(document).ready(function(){
	
	
	$("#name input[name='image']").on("change",function(){
	
		var formData = new FormData();
		var files = $("input[name='image']")[0].files;
		
		for(var i=0; i<files.length; i++) {
			formData.append("images", files[i]);
		}
		
		$.ajax({
		    url: '/uploadImage',
		    type: 'post',
		    data : formData,
		    processData : false,
			contentType : false,
			beforeSend : function(xmlHttpRequest){   
				xmlHttpRequest.setRequestHeader(csrfHeader,
						csrfToken);
		    },
		    success: function (data){
		    	console.log(data);
		    	$("#test").html(`<img src="\${data}"></img>`)
		    	
		    },
		    error : function (){
		    	alert("이미지 등록 실패");
		    }
		});
		
		
	})
});

</script>
</html>
