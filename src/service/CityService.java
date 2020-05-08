package service;

import domain.City;
import domain.PageBean;

import java.util.List;

public interface CityService {
    List<City> findAll();

    PageBean<City> pageQuery(int currentPage,int pageSize);

    boolean editById(String cid,String cname);

    boolean deleteByid(String cid);

    boolean findByName(String cname);

    boolean addCity(String cname);
}
