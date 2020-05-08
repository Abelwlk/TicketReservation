package web.servlet;

import domain.Order;
import domain.PageBean;
import domain.ResultInfo;
import service.OrderService;
import service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order/*")
public class OrderServlet extends BaseServlet {

    private OrderService orderService=new OrderServiceImpl();

    public void pageQuery(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String uid=request.getParameter("uid");
        String currentPageStr=request.getParameter("orderCurrentPage");
        int pageSize=5;
        int currentPage=0;
        if(currentPageStr != null&&currentPageStr.length()>0&&Integer.parseInt(currentPageStr)>0)
        {
            currentPage=Integer.parseInt(currentPageStr);
        }else {
            currentPage=1;
        }
        PageBean<Order> pb=orderService.pageQuery(uid,currentPage,pageSize);
        writeValue(pb,response);
    }

    public void cancelOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String orderId=request.getParameter("orderId");
        ResultInfo info=new ResultInfo();
        if(orderService.cancelOrder(orderId)){
            info.setFlag(true);
            info.setErrorMsg("退订成功！");
        }else {
            info.setFlag(false);
            info.setErrorMsg("发成前2小时无法在线退订！");
        }
        writeValue(info,response);
    }
}
