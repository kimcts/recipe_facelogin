$(document).ready(function(){
	
	if($('.newPasswordForm').data("key") === ""){
		alert("잘못된 접근입니다");
		window.location.href = "/main";
	}
	
	let dataInputCheck = true;
		
	$("#newPassword").on("click",function(e){
		
		e.preventDefault();
		
		$('.newPasswordForm input').each(function(){
			console.log($(this).val())
			if($(this).val().trim() == '') {
			   dataInputCheck = false;
			}
		})
		if(!dataInputCheck){
			alert("데이터 입력 필수");
			dataInputCheck = true;
			return;
		}
		else if($("input[name='password']").val() !=
			$("input[name='passwordCheck']").val()){
			$("input[name='password']").focus();
			alert("비밀번호 체크 필요");
			return;
		}

		let passwordData = {
			
			key : $('.newPasswordForm').data("key"),
			password : $(`input[name='password']`).val(),
			passwordCheck : $(`input[name='passwordCheck']`).val(),
			
		}
		
		
		$.ajax({
		    url: '/newpassword',
		    type: 'post',
		    data : JSON.stringify(passwordData),
			contentType : "application/json; charset=UTF-8",
			beforeSend : function(xmlHttpRequest){   
				xmlHttpRequest.setRequestHeader(csrfHeader,
						csrfToken);
            },
		    success: function (data){
		    	alert(data);
		 		window.location.href = "/login";

		    },
		    error: function (error){
		     	alert(error.responseText);
		     	window.location.href = "/main";
		    }
		});
		
		
	})
	
		
	
	
})