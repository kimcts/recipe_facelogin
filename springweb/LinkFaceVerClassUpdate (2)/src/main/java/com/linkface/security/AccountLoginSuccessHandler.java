package com.linkface.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.linkface.util.Aes256;

// 로그인 성공 시 처리 로직
public class AccountLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		if(!account.getUserStatus().isPasswordNonExpired()) {
			
			request.getSession().setAttribute("key", Aes256.encrypt(Long.toString(account.getUserInfo().getUserKey())));
			request.getSession().setAttribute("message","6개월 동안 패스워드를 변경하지 않았습니다. 패스워드를 다시 설정해주세요");
			response.sendRedirect("/newpassword");
			return;
			
		}
		
		response.sendRedirect("/main");
		
	}

}
