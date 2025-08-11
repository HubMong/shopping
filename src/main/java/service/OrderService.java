package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.BookMapper;
import mapper.OrderMapper;
import model.Book;
import model.Order;

@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private BookMapper bookMapper;  // Book 정보를 가져오는 Mapper 추가

    // 주문 추가
    public int insertOrder(Order order) {
        return orderMapper.insert(order);
    }

    // 특정 회원의 모든 주문 조회
    public List<Order> getOrdersByMemberId(int memberId) {
        return orderMapper.selectByMemberId(memberId);
    }

    // 모든 주문 조회
    public List<Order> getAllOrders() {
        return orderMapper.selectAll();
    }

    // 주문 ID로 주문 조회
    public Order getOrderById(int orderId) {
        Order order = orderMapper.selectById(orderId);  // 주문 ID로 주문 조회
        
        // 주문에 포함된 책 정보 가져오기
        Book book = bookMapper.selectBookById(order.getBookId());  // 책 ID로 Book 정보 조회
        order.setBook(book);  // 책 정보 설정

        return order;
    }
}
