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

    // 주문 등록
    public int insertOrder(Order order) {
        return orderMapper.insert(order);
    }

    // 특정 회원 주문 목록 조회
    public List<Order> getOrdersByMemberId(int memberId) {
        return orderMapper.selectByMemberId(memberId);
    }

    // 전체 주문 목록 조회
    public List<Order> getAllOrders() {
        return orderMapper.selectAll();
    }

    // 주문 검색 (예: 주문번호, 회원명 등 키워드 검색)
    public List<Order> searchOrders(String keyword) {
        return orderMapper.search(keyword);
    }

    // 주문 삭제 (id 기준)
    public int remove(int id) {
        return orderMapper.delete(id);
    }

    // 주문 삭제 메서드 (기존 remove와 중복, 필요 시 구현)
    public void deleteOrder(int orderId) {
        orderMapper.delete(orderId);
    }
}
