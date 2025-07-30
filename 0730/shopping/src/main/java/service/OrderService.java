package service;

import mapper.OrderMapper;
import model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

    public int insertOrder(Order order) {
        return orderMapper.insert(order);
    }

    public List<Order> getOrdersByMemberId(int memberId) {
        return orderMapper.selectByMemberId(memberId);
    }

    public List<Order> getAllOrders() {
        return orderMapper.selectAll();
    }

}
