package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mapper.OrderMapper;
import model.Order;
import model.OrderItem;

@Service
public class OrderService {
	

    @Autowired
    private OrderMapper orderMapper;

    @Transactional
    public void processOrder(Order order) {
        orderMapper.insertOrder(order); // 주문 정보 저장
        for (OrderItem item : order.getItems()) {
            item.setOrderId(order.getOrderId());
            orderMapper.insertOrderItem(item); // 주문 상품 정보 저장
        }
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        return orderMapper.selectOrderItemsByOrderId(orderId);
    }

    public List<Order> getOrdersByMemberId(String memberId) {
        return orderMapper.selectOrdersByMemberId(memberId);
    }
}