<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/includes/tags.jsp" %>
<%@ include file="/resources/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/resources/includes/jqueryandcsrf.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet" href="/resources/css/modal.css">
<title>Admin</title>
</head>
<link href="/resources/css/styles2.css" rel="stylesheet" />
<style>
#userRecipe .btnPage{

	background-color : #bdf2d5;
	color : white;
}
#userSanctions .btnPage{

	background-color : #e9a1a1;
	color : white;
}
</style>
<body>
	<br><br>
	<div class="container">
	  <div class="row justify-content-md-center">
	       <div class="col col-lg-5">
	           <div class="card mb-3">
	               <div class="card-header">
	                   <i class="fas fa-chart-area me-1"></i>
	                   	<select class="selectpicker form-control" data-type="categoryViewsCount">
							<option value="all" selected>전체</option>              
							<option value="today">오늘</option>
						</select>
	               </div>
	               <div class="card-body"><canvas id="categoriViewsCountchart" width="500" height="300"></canvas></div>
	           </div>
	       </div>
	       <div class="col col-lg-5">
	           <div class="card mb-5">
	               <div class="card-header">
	                   <i class="fas fa-chart-bar me-1"></i>
	                   <select class="selectpicker form-control" data-type="mostActiveUsers">
							<option value="all" selected>전체</option>              
							<option value="month">달</option>              
							<option value="today">오늘</option>
						</select>
	               </div>
	               <div class="card-body"><canvas id="mostActiveUsersChart" width="500" height="300"></canvas></div>
	           </div>
	       </div>
	   </div>
   </div>
	
	<div class="container">
	   <div class="row">
           <div class="col-lg-8 mx-auto card mb-3">
              	<br>
               <div class="card-header">
                  <div class="input-group">
	                <input id="search" name="search" class="form-control" type="search" placeholder="아이디 검색" aria-label="Search">
  					<button id="searchBtn" class="btn btn-outline-info flex-shrink-0" type="submit">검색</button>
	            </div>
               </div>
               <div class="card-body">
               <ul id="searchUserId" class="list-group">
				  아이디를 입력해주세요
				</ul>
               </div>
          </div>
       </div>
	</div>
	
	<br><br><br>
	<div class="container">
	  <div class="row justify-content-md-center">
	       <div class="col col-lg-6">
	           <div class="card mb-3">
	               <div class="card-header">
	              		레시피
	               </div>
	               <div id="userRecipe" class="card-body" style="display:none">
	               </div>
	           </div>
	       </div>
	       <div class="col col-lg-6">
	           <div class="card mb-5">
	               <div class="card-header">
	              		제재 내역
	               </div>
	               <div id="userSanctions" class="card-body" style="display:none">
	               </div>
	           </div>
	       </div>
	   </div>
   </div>

<div class="modal">
	<div class="modal_content">
		<div class="modal_modal delete">
			<h2>사유를 작성해주세요</h2>
		  	<form id="delete">
				<div>
					<label>게시글번호</label>
					<input type="text" name="recipeId" readonly>
				</div>
				<div>
					<label>사유</label>
					<input type="text" name="reasons" maxlength="50">
				</div>
			</form>
			<button class="btn btn-primary btn_delete">제출</button>
  			<button class="btn btn-danger btn_close">닫기</button> 
		</div>
		<div class="modal_modal role">
			<h2>권한을 선택해주세요</h2>
			<form id="role">
				<div>
					<label>아이디</label>
					<input type="text" name="id" readonly/>	
				</div>
				<div>
					<label>변경 등급</label>
					<input type="radio" name="role" value="MEMBER" checked/> 맴버
					<input type="radio" name="role" value="MANAGER" /> 매니저
				</div>
			</form>
			<button class="btn_role">제출</button>
  			<button class="btn_close">닫기</button> 
		</div>
		<div class="modal_modal sanctions">
			<h2>정지날짜와 사유를 작성해주세요</h2>
			<form id="sanctions">
				<div>
					<label>아이디</label>
					<input type="text" name="id" readonly/>	
				</div>
				<div>
					<label>정지날짜 선택</label>
					<input type="radio" name="day" value="day" checked/> 3일
					<input type="radio" name="day" value="week" /> 7일
					<input type="radio" name="day" value="month" /> 30일
					<input type="radio" name="day" value="permanence" /> 영구
				</div>
				<div>
					<label>사유</label>
					<input type="text" name="reasons" maxlength="50"/>	
				</div>
			</form>
			<button class="btn_sanctions">제출</button>
  			<button class="btn_close">닫기</button> 
		</div> 
  	</div>
</div>

	<script>
		
		// 차트 데이터 가져오기
		function getChartData(day,type) {
			
			let result;
			
			$.ajax({
			    url: '/chartdata',
			    type: 'post',
			    async: false,
			    data : JSON.stringify({day,type}),
				contentType : "application/json; charset=UTF-8",
				beforeSend : function(xmlHttpRequest){   
					xmlHttpRequest.setRequestHeader(csrfHeader,
							csrfToken);
			    },
			    success: function (data){
			    	result = data;
			    }
			});
			return result;
		}
		// 유저 정보 가져오기
		function getUserInfo(id) {
			
			let result;
			
			$.ajax({
			    url: '/userinfo',
			    type: 'post',
			    data : id,
			    async: false,
				contentType : "application/text; charset=UTF-8",
				beforeSend : function(xmlHttpRequest){   
					xmlHttpRequest.setRequestHeader(csrfHeader,
							csrfToken);
			    },
			    success: function (data){
			    	result = data;
			    },
			    error : function (){
			    	alert("사용자 조회에 실패했습니다");
			    }
			});
			return result;
		}
	
		$(document).ready(function(){
		
			// 업데이트 차트
			function updateChart(day,type){
				if(type === "categoryViewsCount"){
					let {category,viewsCount} = getChartData(day,type);
					pieChart.data.labels = category;
					pieChart.data.datasets[0].data = viewsCount;
					pieChart.update();
				}
				else{
					let {userId,recipeCount} = getChartData(day,type);
					barChart.data.labels = userId;
					barChart.data.datasets[0].data = recipeCount;
					barChart.update();
				}
			}
			
			// 유저 정보 테이블 생성
			function createUserInfoTable(userInfo){
				$(".userInfo").html();
				let str = `
		    		<table class="table table-bordered">
						<thead>
							<tr class="table-info">
						    	<th scope="col">아이디</th>
						    	<th scope="col">이름</th>
						    	<th scope="col">등급</th>
						    	<th scope="col">가입일</th>
						    	<th scope="col">인증</th>
						    	<th scope="col">만료</th>
						    	<th scope="col">정지</th>
						    	<th scope="col">작성글</th>
						    </tr>
					    </thead>
					    <tbody>
						    <tr>
					    	    <td>\${userInfo.id}</td>
					    	    <td>\${userInfo.name}</td>
					    	    <td>\${userInfo.role == "ROLE_ADMIN" ?
					    	    		"관리자" : userInfo.role == "ROLE_MANAGER" ? 
					    	    		"매니저" : userInfo.role == "ROLE_MEMBER" ? 
					    	    		"맴버" : "비인증맴버"}
					    	    </td>
					    	    <td>\${userInfo.createDate}</td>
					    	    <td>\${userInfo.emailAuth == true ? "O" : "X"}</td>
					    	    <td>\${userInfo.idNonExpired == false ? "O" : "X"}</td>
					    	    <td>\${userInfo.enabled == false ? "O" : "X"}</td>
					    	    <td>\${userInfo.foodnames.length}</td>
					    	</tr>
				    	</tbody>
			        </table>`;
			        
			        
			     str += `
				    	 <div class="pagination justify-content-end">
					 		<sec:authorize access="hasRole('ROLE_ADMIN')">
					 			<button id="btnRole" type="button" class="btn btn-success">Role change</button>
							</sec:authorize>
							<button id="btnSanctions" type="button" class="btn btn-warning">Sanctions</button>
						  </div>
			      		`
		    	$("#searchUserId").html(str);
			}
			
			// 유저 레시피 테이블 생성
			function createUserRecipeTable(userInfo){
				
				$("#userRecipe").html();
				
		    	if(userInfo.foodnames.length == 0){
		    		$("#userRecipe").html("작성한 레시피가 없습니다");
		    		return;
		    	}
		   
		    	let str = `<table class="table table-bordered">
								<thead>
									<tr class="table-success">
										<th scope="col">게시글 번호</th>
										<th scope="col">레시피명</th>
										<th scope="col">카테고리</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>
							<tbody>`
						
		    	// 길이가 30보다 작다면 페이지처리 안함
		    	let length = userInfo.foodnames.length < 30 ?
		    					userInfo.foodnames.length :
		    						 30;
					
		    	for(let i = 0; i < length; i++){	
			    	str += `<tr>
			    				<td>\${userInfo.foodnames[i].recipeid}</td>
			    				<td>\${userInfo.foodnames[i].recipenmko}</td>
			    				<td>\${userInfo.foodnames[i].tynm}</td>
			    				<td>\${userInfo.foodnames[i].createDate}</td>
			    			</tr>`
			    }
	    		str += "</tbody></table>"
				
	    		
    			for(let i = 1; i <= Math.ceil(userInfo.foodnames.length / 30); i++){
	    			str += `<button class="btnPage">\${i}</button>`;
    			}	
			
		    	$("#userRecipe").html(str);
				
			}
			function createUserSanctionsTable(userInfo){
				
				$("#userSanctions").html();
				
		    	if(userInfo.sanctions.length == 0){
		    		$("#userSanctions").html("제재 내역이 없습니다");
		    		return;
		    	}
		   
		    	let str = `<table class="table table-bordered">
								<thead>
									<tr class="table-danger">
										<th scope="col">사유</th>
										<th scope="col">게시글</th>
										<th scope="col">관리자</th>
										<th scope="col">제재일</th>
									</tr>
								</thead>
							<tbody>`
							
				let length = userInfo.sanctions.length < 30 ?
	    				userInfo.sanctions.length : 30;

		    	for(let i = 0; i < length; i++){	
			    	str += `<tr>
			    				<td>\${userInfo.sanctions[i].reasons}</td>
			    				<td>\${userInfo.sanctions[i].recipeid == null ? "X" : userInfo.sanctions[i].recipeid}</td>
			    				<td>\${userInfo.sanctions[i].sanctionerName}</td>
			    				<td>\${userInfo.sanctions[i].createDate}</td>
			    			</tr>`
			    }
	    		str += "</tbody></table>"
	    		
    			for(let i = 1; i <= Math.ceil(userInfo.sanctions.length / 30); i++){
	    			str += `<button class="btnPage">\${i}</button>`;
    			}	

		    	$("#userSanctions").html(str);
				
			}
			
			
			// 조회중인 유저 정보
			let userInfo;
			
			// 원형 차트
			let {category,viewsCount} = 
				getChartData($("select").eq(0).find("option:selected").val(),
						$("select").eq(0).data("type"));
			let pieChart = new Chart($("#categoriViewsCountchart"), {
			    type: 'pie',
			    data: {
			      labels: category,
			      datasets: [
			    	  {
					        label: "Population (millions)",
					        backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
					        data: viewsCount
			    	  }]
			    },
			    options: {
			      responsive: false,
			      title: 
			      {
			        display: true,
			        text: '카테고리별 조회수'
			      }
			    }
			});
			
			// 바 차트
			let {userId,recipeCount} = 
				getChartData($("select").eq(1).find("option:selected").val(),
						$("select").eq(1).data("type"));
			let barChart = new Chart($("#mostActiveUsersChart"), {
			    type: 'bar',
			    data: {
			      labels: userId,
			      datasets: [
			        {
			          label: "Population (millions)",
			          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
			          data: recipeCount
			        }
			      ]
			    },
			    options: {
			    	scales: {
			            yAxes: [{
			                display: true,
			                ticks: {
			                    suggestedMin: 0
			                }
			            }]
			        },
			      legend: { display: false },
			      responsive: false,
			      title: {
			        display: true,
			        text: '레시피 최다 작성자'
			      }
			    }
			});
			
			// 다른 날짜 선택시 차트 업데이트
			$("select").on("change",function(){
				updateChart($(this).find("option:selected").val(),$(this).data("type"));
			})
			
			// 유저 목록 불러오기
			$("#search").on("input",function(){
				
				if($("#userRecipe").css("display") === "block" || 
						$("#userSanctions").css("display") === "block"){
					$("#userRecipe").hide();
					$("#userSanctions").hide();
				}
				
				let id = $(this).val();
				
				if(id === "" || id.includes(" ")){
					$("#searchUserId").html("아이디를 입력해주세요");
					return
				}
				
				$.ajax({
				    url: '/autocompleteuserid',
				    type: 'post',
				    data : id,
					contentType : "application/text; charset=UTF-8",
					beforeSend : function(xmlHttpRequest){   
						xmlHttpRequest.setRequestHeader(csrfHeader,
								csrfToken);
				    },
				    success: function (data){
				    	let str = "";
				    	data.forEach( id => str+= `<li class="list-group-item userId">\${id}</li>` );
				    	$("#searchUserId").html(str);
				    },
				    error : function (){
				    	$("#searchUserId").html("해당하는 유저가 존재하지 않습니다");
				    }
				});
				
			});
			
			
			// 유저 선택시 유저 정보 출력
			$("#searchUserId").on("click","li",function(){
				
				let id = $(this).html();
				userInfo = getUserInfo(id);
				$(".userRecipe").html();
				
				createUserInfoTable(userInfo);
				createUserRecipeTable(userInfo);
				createUserSanctionsTable(userInfo);
				$(".selectUser").show();
				$("#userRecipe").show();
				$("#userSanctions").show();
			})
			
			// 작성글 페이지 버튼 클릭
			$("#userRecipe").on("click",".btnPage",function(){
				// 테이블 비움
				$("#userRecipe tbody tr").remove();
				let page = $(this).text();
				let str = "";
				// 데이터의 길이보다 페이지가 더 많다면 데이터의 길이만큼만 출력
				let length = userInfo.foodnames.length <= page * 30 ?
								userInfo.foodnames.length :
								page * 30;

				// 만들고 추가
				for(let i = (page - 1) * 30; i < length; i++){
					str += `<tr>
			    				<td>\${userInfo.foodnames[i].recipeid}</td>
			    				<td>\${userInfo.foodnames[i].recipenmko}</td>
			    				<td>\${userInfo.foodnames[i].tynm}</td>
			    				<td>\${userInfo.foodnames[i].createDate}</td>
			    			</tr>`
				}
				$("#userRecipe tbody").append(str);
				
			})
			
			// 제재사유 페이지 처리
			$("#userSanctions").on("click",".btnPage",function(){
				// 테이블 비움
				$("#userSanctions tbody tr").remove();
				let page = $(this).text();
				let str = "";
				// 데이터의 길이보다 페이지가 더 많다면 데이터의 길이만큼만 출력
				let length = userInfo.sanctions.length <= page * 30 ?
								userInfo.sanctions.length :
								page * 30;

				// 만들고 추가
				for(let i = (page - 1) * 30; i < length; i++){
					str += `<tr>
			    				<td>\${userInfo.sanctions[i].reasons}</td>
			    				<td>\${userInfo.sanctions[i].recipeid == null ? "X" : userInfo.sanctions[i].recipeid}</td>
			    				<td>\${userInfo.sanctions[i].sanctionerName}</td>
			    				<td>\${userInfo.sanctions[i].createDate}</td>
			    			</tr>`
				}
				$("#userSanctions tbody").append(str);
				
			})
			
			// 작성글 클릭
			$("#userRecipe").on("click","table tr",function(){
				
				deleteRecipe = $(this);
			
				if(confirm(deleteRecipe.children().eq(0).text() + "번 게시글을 삭제하시겠습니까?")){
					
					$(".selectUser").hide();
					$("#delete input[name='recipeId']").val(deleteRecipe.children().eq(0).text());
					$(".modal").show();
					$(".delete").show();
				}
			})
			// 유저 권한 변경 버튼 클릭
			$("#searchUserId").on("click","#btnRole",function(){
			
				$("#role input[name='id']").val(userInfo.id);
				$(".selectUser").hide();
				$(".modal").show();
				$(".role").show();
				
			})
			// 유저 제제 버튼 클릭
			$("#searchUserId").on("click","#btnSanctions",function(){

				$("#sanctions input[name='id']").val(userInfo.id);
				$(".selectUser").hide();
				$(".modal").show();
				$(".sanctions").show();
				
			})
			
			// 글 삭제 모달 제출
			$(".btn_delete").on("click",function(){
				
				if($("#delete input[name='reasons']").val() === ""){
					alert("사유는 필수입력입니다.");
					return
				}
				
				let deleteRecipe = {
					recipeId : $("#delete input[name='recipeId']").val(),
					reasons : $("#delete input[name='reasons']").val()
				};

				$.ajax({
				    url: '/admindeleterecipe',
				    type: 'post',
				    data : JSON.stringify(deleteRecipe),
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xmlHttpRequest){   
						xmlHttpRequest.setRequestHeader(csrfHeader,
								csrfToken);
				    },
				    success: function (result){
				    	alert(result);
				    	userInfo = getUserInfo(userInfo.id);
				    	createUserInfoTable(userInfo);
				    	createUserRecipeTable(userInfo);
				    	createUserSanctionsTable(userInfo);
				    },
				    error : function (error){
				    	alert(error.responseText);
				    }
				});
				
				$(".selectUser").show();
				$(".modal").hide();
				$(".modal_modal ").hide();
				$(".modal form").each(function(){
					this.reset();
				})
			})
			// 권한 변경 모달 제출
			$(".btn_role").on("click",function(){
				
				let roleChangeUser = {
					id : $("#role input[name='id']").val(),
					role : $('#role input[name="role"]:checked').val()
				};
				
				$.ajax({
				    url: '/changeuserrole',
				    type: 'post',
				    data : JSON.stringify(roleChangeUser),
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xmlHttpRequest){   
						xmlHttpRequest.setRequestHeader(csrfHeader,
								csrfToken);
				    },
				    success: function (data){
				    	alert(data);
				    	userInfo = getUserInfo(userInfo.id);
				    	createUserInfoTable(userInfo);
				    },
				    error : function (error){
				    	alert(error.responseText);
				    }
				});
		
				$(".selectUser").show();
				$(".modal").hide();
				$(".modal_modal ").hide();
				$(".modal form").each(function(){
					this.reset();
				})
			})
			// 유저 제재 모달 제출
			$(".btn_sanctions").on("click",function(){
				
				if($("#sanctions input[name='reasons']").val() === ""){
					alert("사유는 필수입력입니다.");
					return
				}
				
				let sanctionsUser = {
					id : $("#sanctions input[name='id']").val(),
					day : $('#sanctions input[name="day"]:checked').val(),
					reasons : $("#sanctions input[name='reasons']").val()
				};
				
				$.ajax({
				    url: '/adminsanctionsuser',
				    type: 'post',
				    data : JSON.stringify(sanctionsUser),
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(xmlHttpRequest){   
						xmlHttpRequest.setRequestHeader(csrfHeader,
								csrfToken);
				    },
				    success: function (data){
				    	alert(data);
				    	userInfo = getUserInfo(userInfo.id);
				    	createUserInfoTable(userInfo);
				    	createUserSanctionsTable(userInfo);
				    },
				    error : function (error){
				    	alert(error.responseText);
				    }
				});
				
				$(".selectUser").show();
				$(".modal").hide();
				$(".modal_modal ").hide();
				$(".modal form").each(function(){
					this.reset();
				})
			})
			
			// 모든 종류의 모달 버튼 클릭 시 form 리셋
			
			// 닫기 클릭
			$(".btn_close").on("click",function(){
				$(".selectUser").show();
				$(".modal").hide();
				$(".modal_modal ").hide();
				$(".modal form").each(function(){
					this.reset();
				})
			})
			
		})
	</script>
	<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>