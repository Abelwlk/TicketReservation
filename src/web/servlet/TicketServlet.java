package web.servlet;

import domain.PageBean;
import domain.ResultInfo;
import domain.Ticket;
import org.apache.commons.beanutils.BeanUtils;
import org.omg.CORBA.PRIVATE_MEMBER;
import service.TicketService;
import service.impl.TicketServiceImpl;
import utils.UUid;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Map;

@WebServlet("/ticket/*")
public class TicketServlet extends BaseServlet {

    private TicketService ticketService=new TicketServiceImpl();

    public void pageQuery(HttpServletRequest request,HttpServletResponse response) throws IOException {

        String currentPageStr=request.getParameter("ticketCurrentPage");
        String startCid = request.getParameter("tStartCid");
        String arriveCid = request.getParameter("tArriveCid");
        String date=request.getParameter("tDate");
        int pageSize=3;
        int currentPage=0;
        if(currentPageStr != null&&currentPageStr.length()>0&&Integer.parseInt(currentPageStr)>0)
        {
            currentPage=Integer.parseInt(currentPageStr);
        }else {
            currentPage=1;
        }
        PageBean<Ticket> pb = ticketService.pageQuery(startCid,arriveCid,date,currentPage,pageSize);
        writeValue(pb,response);
    }

    public void reservation(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String tid=request.getParameter("tid");
        String uid=request.getParameter("uid");
        ResultInfo info=new ResultInfo();
        int result =ticketService.reservation(uid,tid);
        if(result==1){
            info.setFlag(true);
        }else if(result==0){
            info.setFlag(false);
            info.setErrorMsg("发车两小时之内不可在线预定");
        }else if(result==-1){
            info.setFlag(false);
            info.setErrorMsg("票已抢光");
        }
        writeValue(info,response);
    }
    public void add(HttpServletRequest request,HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {
        String startCid=request.getParameter("startCid");
        String arriveCid=request.getParameter("arriveCid");
        String date=request.getParameter("date");
        String time=request.getParameter("time");
        String price=request.getParameter("price");
        String num=request.getParameter("num");

        Ticket ticket =new Ticket();
        ticket.setTid(UUid.getShortUUid());
        ticket.setStartCid(startCid);
        ticket.setArriveCid(arriveCid);
        ticket.setDate(LocalDate.parse(date));
        ticket.setTime(LocalTime.parse(time));
        ticket.setPrice(Integer.parseInt(price));
        ticket.setNum(Integer.parseInt(num));

        ResultInfo info=new ResultInfo();

        if(ticketService.addTicket(ticket)){
            info.setFlag(true);
        }else {
            info.setFlag(false);
            info.setErrorMsg("添加失败");
        }
        writeValue(info,response);
    }

    public void findById(HttpServletRequest request,HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {
        String tid=request.getParameter("tid");
        writeValue(ticketService.findByid(tid),response);
    }

    public void edit(HttpServletRequest request,HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {
        String tid=request.getParameter("tid");
        String time=request.getParameter("time");
        String price=request.getParameter("price");
        String num=request.getParameter("num");

        Ticket ticket=new Ticket();
        ticket.setTid(tid);
        ticket.setTime(LocalTime.parse(time));
        ticket.setPrice(Integer.parseInt(price));
        ticket.setNum(Integer.parseInt(num));
        ResultInfo info=new ResultInfo();

        if(ticketService.edit(ticket)){
            info.setFlag(true);
        }else {
            info.setFlag(false);
            info.setErrorMsg("修改失败！");
        }
        writeValue(info,response);
    }

    public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException, InvocationTargetException, IllegalAccessException {
        String tid=request.getParameter("tid");
        ResultInfo info=new ResultInfo();
        if(ticketService.delete(tid)){
            info.setFlag(true);
        }else {
            info.setFlag(false);
            info.setErrorMsg("删除失败！");
        }
        writeValue(info,response);
    }

}
