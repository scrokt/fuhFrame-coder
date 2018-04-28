package com.rt.web.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

@Component("login")
public class LoginFilter extends GenericFilterBean {

	public void doFilter(final ServletRequest req, final ServletResponse res,
			final FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		RequestHolder.set(request, response);
		String requestURI = request.getRequestURI();
		if (requestURI.endsWith("/")) {
			response.sendRedirect(request.getContextPath() + "/goIndexLu.action");
		} else {
			chain.doFilter(request, response);
		}
		RequestHolder.remove();
	}

}
