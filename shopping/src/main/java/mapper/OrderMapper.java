package mapper;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderMapper {
    void insertOrder(Order order);
    void insertOrderItem(OrderItem orderItem);
    List<OrderItem> selectOrderItemsByOrderId(int orderId);
    List<Order> selectOrdersByMemberId(String memberId);
}