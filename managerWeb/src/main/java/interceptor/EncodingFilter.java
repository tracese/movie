package interceptor;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EncodingFilter implements Filter {
    private String coding = "utf-8";
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        coding = filterConfig.getInitParameter("coding");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        request.setCharacterEncoding(coding);
        response.setCharacterEncoding(coding);
        filterChain.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
