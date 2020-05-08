package service;

import domain.Order;
import domain.PageBean;

public interface OrderService {
    boolean cancelOrder(String orderId);
    PageBean<Order> pageQuery(String uid, int currentPage, int pageSize);
}
