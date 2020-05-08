package test;

import dao.OrderDao;
import dao.TicketDao;
import dao.impl.OrderDaoImpl;
import dao.impl.TicketDaoImpl;
import domain.Ticket;
import org.junit.Test;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class TicketTest {
    TicketDao ticketDao=new TicketDaoImpl();
    OrderDao orderDao=new OrderDaoImpl();
    @Test
    public void test(){
        //System.out.println(ticketDao.queryTotalCount("8Pz7tqCi","8qPQ0Smf","2019-10-15"));
        List<Ticket> list = ticketDao.queryByPage("8Pz7tqCi","8qPQ0Smf","2019-10-15",5,5);
        for (Ticket ticket : list) {
            System.out.println(ticket);
        }
    }
    @Test
    public  void test02(){
        System.out.println(ticketDao.queryByTid("0GTCuHP3"));
        DateTimeFormatter df=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        System.out.println(df.format(LocalDateTime.now().withNano(0)));
        //orderDao.addOrder("wlkkk","0GTCuHP3");
    }

    @Test
    public  void test03(){
        DateTimeFormatter df=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        DateTimeFormatter df2=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime localDateTime=LocalDateTime.parse("2019-10-14 06:00",df);



        System.out.println(localDateTime);
        System.out.println(df2.format(localDateTime));

    }
}
