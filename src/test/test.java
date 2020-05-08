package test;

import dao.UserDao;
import dao.impl.UserDaoImpl;
import domain.Ticket;
import domain.User;
import org.junit.Test;
import service.TicketService;
import service.impl.TicketServiceImpl;
import utils.UUid;

import java.time.LocalDate;
import java.time.LocalTime;

public class test {

    private UserDao userDao=new UserDaoImpl();
    private TicketService ticketService=new TicketServiceImpl();

    @Test
    public void RegisterTest(){
        User user=new User();
        user.setUsername("testName");
        user.setPassword("test1234");
        user.setTruthName("单元测试");
        user.setTelephone("15501411958");
        user.setIdentity("32072219961110xxxx");
        boolean result = userDao.addUser(user);
        //返回true成功，false失败
        System.out.println(result);
    }

    @Test
    public void ReservationTest(){
        //输入用户id,班次id
        int result = ticketService.reservation("I0WZKjlq", "ZVvL9tOl");
        //返回1代表成功，0代表失败
        System.out.println(result);
    }

    @Test
    public void loginTest(){
        User user=new User();
        user.setUsername("wlkkk");
        user.setPassword("aaa");
        //成功则返回当前登录用户信息，否则用户信息为Null
        User login = userDao.login(user);
        System.out.println(login);
    }

    @Test
    public void addTicketTest(){
        Ticket ticket=new Ticket();
        ticket.setTid(UUid.getShortUUid());
        ticket.setStartCid("8Pz7tqCi");
        ticket.setArriveCid("8qPQ0Smf");
        ticket.setDate(LocalDate.parse("2019-10-29"));
        ticket.setTime(LocalTime.parse("06:00"));
        ticket.setPrice(99);
        ticket.setNum(50);
        //成功返回true,失败报错
        boolean result = ticketService.addTicket(ticket);
        System.out.println(result);
    }
}
