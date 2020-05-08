package dao;

import domain.City;

import java.util.List;
import java.util.Map;

public interface CityDao {
    List<City> queryAll();
    City queryByCid(String cid);
    boolean insertCity(City c);
    Map<String,String> getMap();
    int queryTotalCount();

    List<City> queryByPage(int start, int pageSize);

    boolean editById(String cid,String cname);

    boolean deleteByid(String cid);

    boolean querByName(String cname);

    boolean addCity(String cname);
}
