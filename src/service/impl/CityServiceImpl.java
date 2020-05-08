package service.impl;

import dao.CityDao;
import dao.impl.CityDaoImpl;
import domain.City;
import domain.PageBean;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import service.CityService;
import utils.JDBCUtils;

import java.util.List;

public class CityServiceImpl implements CityService {
    private CityDao cityDao=new CityDaoImpl();

    @Override
    public List<City> findAll() {
        return cityDao.queryAll();
    }

    @Override
    public PageBean<City> pageQuery(int currentPage,int pageSize) {
        PageBean<City> pb=new PageBean<>();
        pb.setCurrentPage(currentPage);

        int totalCount=cityDao.queryTotalCount();
        pb.setTotalCount(totalCount);

        int start=(currentPage-1)*pageSize;
        pb.setList(cityDao.queryByPage(start,pageSize));

        int totalPage=totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize)+1;
        pb.setTotalPage(totalPage);

        return pb;
    }

    @Override
    public boolean editById(String cid,String cname) {
        if(cityDao.editById(cid,cname)){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean deleteByid(String cid) {
        if(cityDao.deleteByid(cid)){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean findByName(String cname) {
        if(cityDao.querByName(cname)){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean addCity(String cname) {
        if (cityDao.addCity(cname)){
            return true;
        }else {
            return false;
        }
    }
}
