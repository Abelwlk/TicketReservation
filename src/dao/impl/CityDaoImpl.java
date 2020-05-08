package dao.impl;

import dao.CityDao;
import domain.City;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import utils.JDBCUtils;
import utils.UUid;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CityDaoImpl implements CityDao {

    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDatasource());

    @Override
    public List<City> queryAll() {
        String sql = "select * from city";
        return template.query(sql, new BeanPropertyRowMapper<City>(City.class));
    }

    @Override
    public City queryByCid(String cid) {
        String sql="select * from city where cid=?";
        return template.queryForObject(sql,new BeanPropertyRowMapper<City>(City.class),cid);
    }

    @Override
    public boolean insertCity(City c) {
        String sql="insert into city values(?,?)";
        return template.update(sql,c.getCid(),c.getCityName())==1;
    }

    @Override
    public Map<String,String> getMap(){
        return template.query("select cid,cityName from city", new ResultSetExtractor<Map>(){
            @Override
            public Map extractData(ResultSet rs) throws SQLException, DataAccessException {
                HashMap<String,String> mapRet= new HashMap<String,String>();
                while(rs.next()){
                    mapRet.put(rs.getString(1),rs.getString(2));
                }
                return mapRet;
            }
        });
    }

    @Override
    public int queryTotalCount() {
        String sql="SELECT COUNT(*) FROM city";
        return template.queryForObject(sql,Integer.class);
    }

    @Override
    public List<City> queryByPage(int start, int pageSize) {
        String sql="SELECT * FROM city ORDER BY cityName LIMIT ?,?";
        return template.query(sql,new BeanPropertyRowMapper<City>(City.class),start,pageSize);
    }

    @Override
    public boolean editById(String cid,String cname) {
        String sql="UPDATE city SET cityName=? WHERE cid=?";
        return template.update(sql,cname,cid)==1;
    }

    @Override
    public boolean deleteByid(String cid) {
        String sql="DELETE FROM city WHERE cid=?";
        return template.update(sql,cid)==1;
    }

    @Override
    public boolean querByName(String cname) {
        String sql="SELECT COUNT(*) FROM city WHERE cityName=?";
        int x=template.queryForObject(sql,Integer.class,cname);
        if(x==1){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean addCity(String cname) {
        String sql="INSERT INTO city VALUES(?,?)";
        return template.update(sql, UUid.getShortUUid(),cname)==1;
    }

}
