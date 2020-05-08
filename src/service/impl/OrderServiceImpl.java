package service.impl;

import dao.OrderDao;
import dao.TicketDao;
import dao.impl.OrderDaoImpl;
import dao.impl.TicketDaoImpl;
import domain.Order;
import domain.PageBean;
import domain.Ticket;
import service.OrderService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderDao orderDao=new OrderDaoImpl();
    private TicketDao ticketDao=new TicketDaoImpl();
    DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public boolean cancelOrder(String orderId) {
        Order order=orderDao.queryById(orderId);
        if(order.getStartDateTime().minusHours(2).isAfter(LocalDateTime.now())){
            ticketDao.updateByTid(order.getTid(),"tuipiao");
            orderDao.updateOrderStatus(order.getOrderId(),0);
            return true;
        }else {
            return false;
        }
    }

    @Override
    public PageBean<Order> pageQuery(String uid, int currentPage, int pageSize) {
        PageBean<Order> pb=new PageBean<>();
        pb.setCurrentPage(currentPage);

        int totalCount=orderDao.queryTotalCount(uid);
        pb.setTotalCount(totalCount);

        int start=(currentPage-1)*pageSize;

        List<Order> orders=orderDao.queryByPage(uid,start,pageSize);
        for (Order o:orders) {
            if(o.getStatus()==1){
                Ticket t=ticketDao.queryByTid(o.getTid());
                if(o.getStartDateTime().isBefore(LocalDateTime.now())){
                    o.setStatus(-1);
                    orderDao.updateOrderStatus(o.getOrderId(),-1);
                }
            }
        }

        pb.setList(orders);

        int totalPage=totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize)+1;
        pb.setTotalPage(totalPage);
        return pb;
    }
}
