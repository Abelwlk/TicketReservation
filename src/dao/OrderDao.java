package dao;

import domain.Order;

import java.time.LocalDateTime;
import java.util.List;

public interface OrderDao {
    boolean addOrder(String tid,String uid, String startCity, String arriveCity, LocalDateTime startDateTime, int Status);
    int queryTotalCount(String uid);
    List<Order> queryByPage(String uid,int start,int pageSize);
    void updateOrderStatus(String orderId,int status);

    Order queryById(String orderId);
}
