package dao.impl;

import dao.TicketDao;
import domain.Ticket;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import utils.JDBCUtils;
import utils.UUid;

import java.util.List;
import java.util.Map;

public class TicketDaoImpl implements TicketDao {
    private JdbcTemplate template=new JdbcTemplate(JDBCUtils.getDatasource());
    @Override
    public Boolean AddTicket(Ticket ticket) {
        String sql="insert into ticket values(?,?,?,?,?,?,?)";
        return template.update(sql, ticket.getTid(),ticket.getStartCid(),ticket.getArriveCid(),ticket.getDate(),ticket.getTime(),ticket.getPrice(),ticket.getNum())==1;
    }

    @Override
    public int queryTotalCount(String startCid, String arriveCid, String date) {
        String sql="select count(*) from ticket where startCid=? and arriveCid=? and date=?";
        return template.queryForObject(sql,Integer.class,startCid,arriveCid,date);
    }

    @Override
    public List<Ticket> queryByPage(String startCid, String arriveCid, String date,int start, int pageSize) {
        String sql="SELECT * FROM ticket WHERE startCid=? AND arriveCid=? AND date=? ORDER BY time LIMIT ?,?";
        return template.query(sql,new BeanPropertyRowMapper<Ticket>(Ticket.class), startCid, arriveCid, date, start, pageSize);
    }

    public Ticket queryByTid(String tid){
        String sql="select * from ticket where tid=?";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Ticket>(Ticket.class),tid);
    }

    @Override
    public boolean updateByTid(String tid, String info) {
        String sql;
        if(info==null){
            sql="UPDATE ticket SET num=num-1 WHERE tid=?";
        }else {
            sql="UPDATE ticket SET num=num+1 WHERE tid=?";
        }
        return template.update(sql,tid)==1;
    }

    @Override
    public boolean edit(Ticket ticket) {
        String sql="UPDATE ticket SET time=? , price=? , num=? WHERE tid=?";
        return template.update(sql,ticket.getTime(),ticket.getPrice(),ticket.getNum(),ticket.getTid())==1;
    }

    @Override
    public boolean delete(String tid) {
        String sql="delete from ticket where tid=?";
        return template.update(sql,tid)==1;
    }


}
