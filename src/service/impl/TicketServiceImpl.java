package service.impl;

import dao.CityDao;
import dao.OrderDao;
import dao.TicketDao;
import dao.impl.CityDaoImpl;
import dao.impl.OrderDaoImpl;
import dao.impl.TicketDaoImpl;
import domain.Order;
import domain.PageBean;
import domain.Ticket;
import service.TicketService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

public class TicketServiceImpl implements TicketService {

    private TicketDao ticketDao=new TicketDaoImpl();
    private OrderDao orderDao=new OrderDaoImpl();
    private CityDao cityDao=new CityDaoImpl();
    private DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    private Map map=cityDao.getMap();

    @Override
    public PageBean<Ticket> pageQuery(String startCid, String arriveCid, String date,int currentPage, int pageSize) {
        PageBean<Ticket> pb=new PageBean<>();
        pb.setCurrentPage(currentPage);

        int totalCount=ticketDao.queryTotalCount(startCid,arriveCid,date);
        pb.setTotalCount(totalCount);

        int start=(currentPage-1)*pageSize;
        pb.setList(ticketDao.queryByPage(startCid,arriveCid,date,start,pageSize));

        int totalPage=totalCount % pageSize == 0 ? totalCount / pageSize : (totalCount / pageSize)+1;
        pb.setTotalPage(totalPage);
        return pb;
    }

    @Override
    public int reservation(String uid,String tid) {
        Ticket ticket = ticketDao.queryByTid(tid);
        if(ticket.getNum()>0){
            if(LocalDate.now().isBefore(ticket.getDate())){
                ticketDao.updateByTid(tid,null);
                orderDao.addOrder(tid,uid,map.get(ticket.getStartCid()).toString(),map.get(ticket.getArriveCid()).toString(), LocalDateTime.parse(ticket.getDate().toString()+" "+ ticket.getTime().toString(),dtf),1);
                return 1;
            }else if(LocalDate.now().isEqual(ticket.getDate())){
                if(LocalTime.now().isBefore(ticket.getTime().minusHours(2))){
                    ticketDao.updateByTid(tid,null);
                    orderDao.addOrder(tid,uid,map.get(ticket.getStartCid()).toString(),map.get(ticket.getArriveCid()).toString(), LocalDateTime.parse(ticket.getDate().toString()+" "+ ticket.getTime().toString(),dtf),1);
                    return 1;
                }else {
                    return 0;
                }
            }else {
                return 0;
            }
        }else {
            return -1;
        }
    }

    @Override
    public boolean addTicket(Ticket ticket) {
        if(ticketDao.AddTicket(ticket)){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public Ticket findByid(String tid) {
        return ticketDao.queryByTid(tid);
    }

    @Override
    public boolean edit(Ticket ticket) {
        if (ticketDao.edit(ticket)){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean delete(String tid) {
        if(ticketDao.delete(tid)){
            return true;
        }else {
            return false;
        }
    }
}
