package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.BookMapper;
import mapper.MemberMapper;
import mapper.OrderMapper;
import model.Book;
import model.Member;
import model.Order;

@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private BookMapper bookMapper;  // Book 정보를 가져오는 Mapper 추가
    
    @Autowired
    private MemberMapper memberMapper;

    // 주문 추가
    public int insertOrder(Order order) {
        return orderMapper.insert(order);
    }

    // 특정 회원의 모든 주문 조회
    public List<Order> getOrdersByMemberId(int memberId) {
    	List<Order> orders = orderMapper.selectByMemberId(memberId);
    	for(Order order : orders) {
    		Book book = bookMapper.selectBookById(order.getBookId());
    		order.setBook(book);
    	}
        return orders;
    }

    // 주문 ID로 주문 조회
    public Order getOrderById(int orderId) {
        Order order = orderMapper.selectById(orderId);  // 주문 ID로 주문 조회
        
        // 주문에 포함된 책 정보 가져오기
        Book book = bookMapper.selectBookById(order.getBookId());  // 책 ID로 Book 정보 조회
        order.setBook(book);  // 책 정보 설정

        return order;
    }
    
    // 모든 주문 조회
    public List<Order> getAllOrders() {
        List<Order> orders = orderMapper.selectAll();
        for (Order order : orders) {
            Book book = bookMapper.selectBookById(order.getBookId());
            Member member = memberMapper.selectById(order.getMemberId());
            order.setBook(book);
            order.setMember(member);
        }
        return orders;
    }
    
    // 주문 검색 (예: 주문번호, 회원명 등 키워드 검색)
    public List<Order> searchOrders(String keyword) {
    	List<Order> orders = orderMapper.search(keyword);	
        for (Order order : orders) {
            Book book = bookMapper.selectBookById(order.getBookId());
            Member member = memberMapper.selectById(order.getMemberId());
            order.setBook(book);
            order.setMember(member);
        }
        return orders;
    }

}