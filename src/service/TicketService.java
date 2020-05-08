package service;

import domain.PageBean;
import domain.Ticket;

public interface TicketService {
    PageBean<Ticket> pageQuery(String startCid, String arriveCid, String date,int currentPage, int pageSize);

    int reservation(String uid,String tid);

    boolean addTicket(Ticket ticket);

    Ticket findByid(String tid);

    boolean edit(Ticket ticket);

    boolean delete(String tid);
}
