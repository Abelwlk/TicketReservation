package dao.impl;

import dao.UserDao;
import domain.User;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import utils.JDBCUtils;
import utils.UUid;

public class UserDaoImpl implements UserDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDatasource());

    /**
     * 登陆
     *
     * @param loginUser 用户名和密码
     * @return 包含一条用户的全部数据
     */
    public User login(User loginUser) {
        try {
            String sql = "select * from user where username=? and password=?";
            User u = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), loginUser.getUsername(), loginUser.getPassword());
            return u;
        } catch (DataAccessException e) {
            //e.printStackTrace();
            return null;
        }
    }

    /**
     * 登陆
     *
     * @param loginUser 用户名和密码
     * @return 包含一条用户的全部数据
     */
    public User QueryByUsername(User loginUser) {
        try {
            String sql = "select * from user where username=?";
            User u = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), loginUser.getUsername());
            return u;
        } catch (DataAccessException e) {
            return null;
        }
    }

    public boolean addUser(User registerUser) {
        if(registerUser.getPassword()==null)
        {
            return true;
        }else {
            String sql = "insert into user values(?,?,?,?,?,?,?)";
            int count = template.update(sql, UUid.getShortUUid(), registerUser.getUsername(), registerUser.getPassword(),registerUser.getTruthName(),registerUser.getTelephone(),registerUser.getIdentity(),registerUser.getStatus());
            return count==1;
        }

    }

    @Override
    public boolean editUser(User editUser) {
        String sql="UPDATE user SET username=?,password=?,truthname=?,telephone=?,identity=? WHERE uid=?";
        return template.update(sql,editUser.getUsername(),editUser.getPassword(),editUser.getTruthName(),editUser.getTelephone(),editUser.getIdentity(),editUser.getUid())==1;
    }
}
