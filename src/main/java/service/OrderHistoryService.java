package service;

import model.OrderHistory;
import java.util.List;

public interface OrderHistoryService {
    
    // 주문 내역 등록
    int insertOrder(OrderHistory order);

    // 특정 회원의 주문 내역 조회
    List<OrderHistory> getOrdersByMemberId(int memberId);

    // 전체 주문 내역 조회 (관리자용)
    List<OrderHistory> getAllOrders();
}
