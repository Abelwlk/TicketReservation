package web.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        //0.强制转换
        HttpServletRequest request= (HttpServletRequest) req;

        //1.获取资源请求路径
        String uri = request.getRequestURI();
        //2.判断是否包含登录相关资源
        if(uri.contains("/index.jsp")||uri.contains("/user/login")||uri.contains("/register.jsp")||uri.contains("/user/register")||uri.contains("/css/")||uri.contains("/fonts/")||uri.contains("/js/")){
            //包含 就是登陆请求，放行
            chain.doFilter(req,resp);
        }else {//不包含，判断是否已经登陆
            Object user = request.getSession().getAttribute("user");
            if(user!=null)
            {//登陆了，放行
                request.setAttribute("login_error"," ");
                chain.doFilter(req,resp);
            }else {//没登陆，跳转登陆
                request.setAttribute("login_error","尚未登陆！");
                request.getRequestDispatcher("/index.jsp").forward(request,resp);
            }
        }
        //chain.doFilter(req,resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

    public void destroy() {

    }


}
