package interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object result = request.getSession().getAttribute(Constant.SESSION_KEY);
        String requestURI = request.getRequestURI();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //还没有登录
        if(result == null){
            //如果是来登录，直接放行
            if((request.getContextPath()+"/login").equals(requestURI)){
                return true;
            }else{
                //如果不是来登录，重定向到登录界面
                response.sendRedirect(request.getContextPath()+"/login");
                return false;
            }
            //已经登录了
        }else{
            //是不是又来登录了
            if((request.getContextPath()+"/login").equals(requestURI)){
                response.sendRedirect(request.getContextPath()+"/main");
                return false;
            }
            return true;
        }
    }
}
