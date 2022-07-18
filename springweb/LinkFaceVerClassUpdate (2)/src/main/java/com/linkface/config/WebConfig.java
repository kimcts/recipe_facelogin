package com.linkface.config;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

@Configuration
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class , SecurityConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}
	@Override
	   protected void customizeRegistration(ServletRegistration.Dynamic registration) {
	      
	      registration.setInitParameter("thorwExceptionIfNoHandlerFound", "true");
	      
	      MultipartConfigElement multipartConfigElement = 
	            new MultipartConfigElement("C:\\upload",1024 * 1024 * 5,1024 * 1024 * 10,1024 * 1024 * 5);
	      registration.setMultipartConfig(multipartConfigElement);
	      
	   }

}
