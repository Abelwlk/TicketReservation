package dao.impl;

import dao.OrderDao;
import domain.Order;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import utils.JDBCUtils;
import utils.UUid;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    private JdbcTemplate template=new JdbcTemplate(JDBCUtils.getDatasource());

    private DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    @Override
    public boolean addOrder(String tid,String uid, String startCity,String arriveCity,LocalDateTime startDateTime,int Status) {
        String sql="insert into `order` values(?,?,?,?,?,?,?,?)";
        return template.update(sql, UUid.getShortUUid(),tid,uid, startCity,arriveCity,dtf.format(startDateTime),dtf.format(LocalDateTime.now().withNano(0)),Status)==1;
    }

    @Override
    public int queryTotalCount(String uid) {
        String sql="SELECT COUNT(*) FROM `order` WHERE uid=?";
        return template.queryForObject(sql,Integer.class,uid);
    }

    @Override
    public List<Order> queryByPage(String uid, int start, int pageSize) {
        String sql="SELECT * FROM `order` WHERE uid=? ORDER BY  createTime DESC LIMIT ?,?";
        return template.query(sql,new BeanPropertyRowMapper<Order>(Order.class),uid,start,pageSize);
    }

    @Override
    public void updateOrderStatus(String orderId,int status) {
        String sql="UPDATE `order` SET status=? WHERE orderid=?";
        template.update(sql,status,orderId);
    }

    @Override
    public Order queryById(String orderId) {
        String sql="SELECT * FROM `order` WHERE orderid=?";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Order>(Order.class),orderId);
    }
}
