package dao;

import domain.Ticket;

import java.util.List;

public interface TicketDao {
    Boolean AddTicket(Ticket ticket);

    int queryTotalCount(String startCid,String arriveCid,String date);

    List<Ticket> queryByPage(String startCid, String arriveCid, String date,int start, int pageSize);

    Ticket queryByTid(String tid);

    boolean updateByTid(String tid,String info);

    boolean edit(Ticket ticket);

    boolean delete(String tid);
}
