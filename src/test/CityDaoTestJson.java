package test;

import dao.CityDao;
import dao.impl.CityDaoImpl;
import domain.City;
import org.junit.Test;
import utils.UUid;

public class CityDaoTestJson {
    private CityDao cityDao=new CityDaoImpl();
    @Test
    public void test01(){
        System.out.println(cityDao.queryAll());
    }
    @Test
    public void test02(){
        System.out.println(cityDao.queryByCid("333"));
    }
    @Test
    public void test03(){
        String[] c=new String[]{"上海","常州","苏州","无锡","南京","连云港"};
        for (int i = 0; i < 6; i++) {
            City cs=new City(UUid.getShortUUid(),c[i]);
            System.out.println(cityDao.insertCity(cs));
        }
    }
}
