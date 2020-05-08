package test;

import dao.UserDao;
import dao.impl.UserDaoImpl;
import domain.User;
import org.junit.Test;

import javax.swing.text.DateFormatter;
import java.text.DateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class UserDaoTestJson {
    @Test
    public void testLogin(){
        User loginUser=new User();
        loginUser.setUsername("wlkkk");
        loginUser.setPassword("11111");
        UserDao dao=new UserDaoImpl();
        User u=dao.login(loginUser);
        System.out.println(u);
    }

    @Test
    public void testRegister(){
        User user=new User();
        user.setUsername("test01");
        user.setPassword("asd123");
        user.setTruthName("王五");
        user.setTelephone("15501411958");
        user.setIdentity("320722xxxxxxxxxxxx");

        UserDao userDao=new UserDaoImpl();
        boolean t=userDao.addUser(user);
        System.out.println(t);
    }
    @Test
    public void t02(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        DateTimeFormatter tt = DateTimeFormatter.ofPattern("HH:mm:ss");
        LocalDate date = LocalDate.now();
        String time=LocalTime.now().format(tt);
        String dt=LocalDateTime.now().format(formatter);
        System.out.println(date);
        System.out.println(time);
        System.out.println(dt);
    }
}
