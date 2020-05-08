package web.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class BaseServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //方法分发
        //01.获取请求路径
        String uri=req.getRequestURI();
        //2.截取方法名
        String methonName = uri.substring(uri.lastIndexOf("/") + 1);
        //3.获取方法对象
        //System.out.println(this);//调用谁就是谁 userservlet
        try {
            //getDeclaredMethod忽略权限访问修饰符
            Method method = this.getClass().getMethod(methonName, HttpServletRequest.class, HttpServletResponse.class);
            //4.执行方法
            //method.setAccessible(true);
            method.invoke(this,req,resp);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    //序列化成json,并传回客户端
    public void writeValue(Object obj,HttpServletResponse response) throws IOException {
        ObjectMapper mapper=new ObjectMapper().findAndRegisterModules();
        response.setContentType("application/json;charset=utf-8");
        mapper.writeValue(response.getOutputStream(),obj);
    }

    public String writeValueAsString(Object obj) throws JsonProcessingException {
        ObjectMapper mapper=new ObjectMapper().findAndRegisterModules();
        return mapper.writeValueAsString(obj);
    }
}
