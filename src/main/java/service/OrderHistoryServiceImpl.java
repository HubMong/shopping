package service;

import mapper.OrderHistoryMapper;
import model.OrderHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderHistoryServiceImpl implements OrderHistoryService {

    @Autowired
    private OrderHistoryMapper orderHistoryMapper;

    @Override
    public int insertOrder(OrderHistory order) {
        return orderHistoryMapper.insert(order);
    }

    @Override
    public List<OrderHistory> getOrdersByMemberId(int memberId) {
        return orderHistoryMapper.selectByMemberId(memberId);
    }

    @Override
    public List<OrderHistory> getAllOrders() {
        return orderHistoryMapper.selectAll();
    }
}
