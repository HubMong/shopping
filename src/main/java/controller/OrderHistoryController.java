package controller;

import model.OrderHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.OrderHistoryService;

import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderHistoryController {

    @Autowired
    private OrderHistoryService orderHistoryService;

    // ✅ [1] 특정 회원 주문 내역 조회
    @GetMapping("/member/{memberId}")
    public String getOrdersByMemberId(@PathVariable int memberId, Model model) {
        List<OrderHistory> orderList = orderHistoryService.getOrdersByMemberId(memberId);
        model.addAttribute("orders", orderList);
        return "order/member_orders"; // → /WEB-INF/views/order/member_orders.jsp
    }

    // ✅ [2] 전체 주문 내역 (관리자)
    @GetMapping("/all")
    public String getAllOrders(Model model) {
        List<OrderHistory> orderList = orderHistoryService.getAllOrders();
        model.addAttribute("orders", orderList);
        return "order/all_orders"; // → /WEB-INF/views/order/all_orders.jsp
    }

    // ✅ [3] 주문 등록 처리
    @PostMapping("/insert")
    public String insertOrder(@ModelAttribute OrderHistory order) {
        orderHistoryService.insertOrder(order);
        return "redirect:/orders/member/" + order.getMemberId(); // 등록 후 내 주문 내역으로 이동
    }
}
