package dao;

import domain.User;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import utils.JDBCUtils;
import utils.UUid;

public interface UserDao {
    User login(User loginUser);
    User QueryByUsername(User loginUser);
    boolean addUser(User registerUser);
    boolean editUser(User editUser);
}
