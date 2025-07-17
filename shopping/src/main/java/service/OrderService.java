package service;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderService {
    void processOrder(Order order);
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    List<Order> getOrdersByMemberId(String memberId);
}