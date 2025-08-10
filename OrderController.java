package controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import model.Book;
import model.CartItem;
import model.Member;
import model.Order;
import model.OrderItem;
import service.BookService;
import service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private BookService bookService;

    @PostMapping("/buyNow")
    public String buyNow(@RequestParam("bookId") int bookId, @RequestParam("quantity") int quantity, HttpSession session, RedirectAttributes redirectAttributes) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/loginform";
        }

        Book book = bookService.getBookById(bookId);
        if (book == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "책 정보를 찾을 수 없습니다.");
            return "redirect:/books";
        }

        List<OrderItem> items = new ArrayList<>();
        OrderItem item = new OrderItem();
        item.setBookId(book.getId());
        item.setQuantity(quantity);
        item.setPrice(book.getPrice());
        item.setTitle(book.getTitle());
        item.setAuthor(book.getAuthor());
        items.add(item);

        Order order = new Order();
        order.setMemberId(loginUser.getId());
        order.setTotalAmount(book.getPrice() * quantity);
        order.setItems(items);

        session.setAttribute("order", order);

        return "redirect:/order/payment";
    }

    @PostMapping("/checkout")
    public String checkout(HttpSession session, RedirectAttributes redirectAttributes) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/loginform";
        }

        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cartMap == null || cartMap.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMsg", "장바구니가 비어있습니다.");
            return "redirect:/cart";
        }

        List<OrderItem> items = new ArrayList<>();
        int totalAmount = 0;
        for (CartItem cartItem : cartMap.values()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setBookId(cartItem.getBook().getId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getBook().getPrice());
            orderItem.setTitle(cartItem.getBook().getTitle());
            orderItem.setAuthor(cartItem.getBook().getAuthor());
            items.add(orderItem);
            totalAmount += cartItem.getBook().getPrice() * cartItem.getQuantity();
        }

        Order order = new Order();
        order.setMemberId(loginUser.getId());
        order.setTotalAmount(totalAmount);
        order.setItems(items);

        session.setAttribute("order", order);

        return "redirect:/order/payment";
    }

    @GetMapping("/payment")
    public String showPaymentPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        Order order = (Order) session.getAttribute("order");
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (order == null || loginUser == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "주문 또는 사용자 정보가 없습니다.");
            return "redirect:/cart";
        }
        model.addAttribute("order", order);
        model.addAttribute("loginUser", loginUser);
        return "user/payment";
    }

    @PostMapping("/confirm")
    public String confirmOrder(HttpSession session, RedirectAttributes redirectAttributes) {
        Order order = (Order) session.getAttribute("order");
        if (order == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "주문 정보가 없습니다.");
            return "redirect:/cart";
        }

        orderService.processOrder(order);

        session.removeAttribute("order");
        session.removeAttribute("cart");

        redirectAttributes.addFlashAttribute("successMsg", "결제 되었습니다.");
        return "redirect:/";
    }
}