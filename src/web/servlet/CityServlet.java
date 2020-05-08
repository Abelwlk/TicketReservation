package web.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import domain.City;
import domain.PageBean;
import domain.ResultInfo;
import service.CityService;
import service.impl.CityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/city/*")
public class CityServlet extends BaseServlet {

    private CityService cityService=new CityServiceImpl();

    public void findAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<City> cs= cityService.findAll();
        writeValue(cs,response);
    }
    public void pageQuery(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String currentPageStr=request.getParameter("cCurrentPage");
        int pageSize=7;
        int currentPage=0;
        if(currentPageStr != null&&currentPageStr.length()>0&&Integer.parseInt(currentPageStr)>0)
        {
            currentPage=Integer.parseInt(currentPageStr);
        }else {
            currentPage=1;
        }

        PageBean<City> pb = cityService.pageQuery(currentPage, pageSize);
        writeValue(pb,response);
    }

    public void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cid=request.getParameter("cid");
        String cname=request.getParameter("cname");
        ResultInfo info=new ResultInfo();
        if(cityService.editById(cid,cname)){
            info.setFlag(true);
        }else {
            info.setFlag(false);
            info.setErrorMsg("修改失败！");
        }
        writeValue(info,response);
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cid=request.getParameter("cid");
        ResultInfo info=new ResultInfo();
        if(cityService.deleteByid(cid)){
            info.setFlag(true);
        }else {
            info.setFlag(false);
            info.setErrorMsg("删除失败！");
        }
        writeValue(info,response);
    }

    public void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cname=request.getParameter("cityName");
        ResultInfo info=new ResultInfo();
        if(cityService.findByName(cname)){
            info.setFlag(false);
            info.setErrorMsg("城市已存在！");
        }else {
            if(cityService.addCity(cname)){
                info.setFlag(true);
            }else {
                info.setFlag(false);
                info.setErrorMsg("添加失败！");
            }
        }
        writeValue(info,response);
    }
}
