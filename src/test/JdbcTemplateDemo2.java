package test;

import domain.User;
import org.junit.Test;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import utils.JDBCUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class JdbcTemplateDemo2 {
    JdbcTemplate template;

    {
            template = new JdbcTemplate(JDBCUtils.getDatasource());
    }

    @Test
    public void Test01() throws SQLException {
        String sql = "update user set password = 'asd123' where username = ?";
        int count = template.update(sql, "wlkkk");
        System.out.println(count);
    }

    @Test
    public void test02() {//只能是一条
        String sql = "select * from user where username=?";
        Map<String, Object> map = template.queryForMap(sql, "wlkkk");
        System.out.println(map);//{uid=I0WZKjlq, username=wlkkk, password=asd123}
    }

    @Test
    public void test03() {
        String sql = "select * from user";
        List<Map<String, Object>> mapList = template.queryForList(sql);
        System.out.println(mapList);//[{uid=I0WZKjlq, username=wlkkk, password=asd123}, {uid=xODYG4TZ, username=admin, password=qwer1234}]
    }

    @Test
    public void test04() {
        String sql = "select * from user";
        List<User> users = template.query(sql, new RowMapper<User>() {
            @Override
            public User mapRow(ResultSet rs, int i) throws SQLException {
                User user = new User();
                user.setUid(rs.getString(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                return user;
            }
        });
        for (User u : users) {
            System.out.println(u);
        }
    }
    @Test
    public void test05() {
        String sql = "select * from user";
        List<User> list = template.query(sql, new BeanPropertyRowMapper<User>(User.class));
        for (User user : list) {
            System.out.println(user);
        }

    }
}
