package test;

import com.fasterxml.jackson.core.JsonToken;
import dao.CityDao;
import dao.TicketDao;
import dao.impl.CityDaoImpl;
import dao.impl.TicketDaoImpl;
import domain.City;
import domain.Ticket;
import org.junit.Test;
import utils.UUid;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

public class CityDaoTest {
    private CityDao cityDao=new CityDaoImpl();
    private TicketDao ticketDao=new TicketDaoImpl();

    @Test
    public void Test01(){
        List<City> cs = cityDao.queryAll();

        for(int i=0;i<cs.size();i++){
            for(int j=0;j<cs.size();j++){
                for(int k=30;k<=31;k++){
                    for(int h=6;h<=18;h=h+2){
                        if(j!=i){
                            Ticket t=new Ticket(UUid.getShortUUid(),cs.get(i).getCid(),cs.get(j).getCid(), LocalDate.of(2019,10,k), LocalTime.of(h,0),109,40);
                            ticketDao.AddTicket(t);
                            System.out.println(t);
                        }
                    }
                }
            }
        }
    }

    @Test
    public void Test02(){
        Map map=cityDao.getMap();
        System.out.println(map);
        System.out.println(map.get("Ex1HanlA"));
    }

    @Test
    public void Test03(){
        System.out.println(cityDao.queryTotalCount());
    }
}
