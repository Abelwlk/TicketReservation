package web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.UserDao;
import dao.impl.UserDaoImpl;
import domain.ResultInfo;
import domain.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet("/user/*")
public class UserServlet extends BaseServlet {

    private UserDao userDao=new UserDaoImpl();

    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, String[]> map = request.getParameterMap();
        User loginUser=new User();
        HttpSession session=request.getSession();
        try {
            BeanUtils.populate(loginUser,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        User user = userDao.login(loginUser);
        ResultInfo info=new ResultInfo();
        if (user==null){
            info.setFlag(false);
            info.setErrorMsg("用户名或密码错误！");
        }else {
            session.setAttribute("user",user);
            info.setFlag(true);
            info.setErrorMsg(user.getStatus());
            System.out.println(user.getStatus());
        }
        writeValue(info,response);

    }

    public void register(HttpServletRequest request, HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {
        request.setCharacterEncoding("utf-8");

        User registerUser=new User();
        Map<String, String[]> map = request.getParameterMap();
        BeanUtils.populate(registerUser,map);
        registerUser.setStatus("0");
        ResultInfo info=new ResultInfo();
        if(userDao.QueryByUsername(registerUser)!=null)
        {
            info.setFlag(false);
            info.setErrorMsg("用户名已存在!");
        }else {
            if(userDao.addUser(registerUser)){
                info.setFlag(true);
            }else {
                info.setFlag(false);
                info.setErrorMsg("注册失败！");
            }
        }
       writeValue(info,response);
    }

    public void exit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        session.removeAttribute("user");
        response.sendRedirect(request.getContextPath()+"/index.jsp");
    }

    public void editUser(HttpServletRequest request, HttpServletResponse response) throws InvocationTargetException, IllegalAccessException, IOException {
        User editUser=new User();
        Map<String, String[]> map = request.getParameterMap();
        BeanUtils.populate(editUser,map);
        ResultInfo info=new ResultInfo();

        HttpSession session=request.getSession();
        if(userDao.editUser(editUser)){
            info.setFlag(true);
            session.setAttribute("user",editUser);
        }else {
            info.setFlag(false);
            info.setErrorMsg("修改失败");
        }
        writeValue(info,response);
    }
}
