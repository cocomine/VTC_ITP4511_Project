package it.itp4511.ea.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "ServletFilter")
public class ServletFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();

        System.out.println("Filtering: " + httpRequest.getRequestURI());
        if(session.getAttribute("user") == null){
            if(!httpRequest.getRequestURI().matches(".*(css|jpg|png|gif|js)")) {
                if (!httpRequest.getRequestURI().endsWith("/login")) {
                    System.out.println("Redirecting to login page");
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
                    return;
                }
            }
        }else{
            request.setAttribute("user", session.getAttribute("user"));
        }

        chain.doFilter(request, response);
    }
}
