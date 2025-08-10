package controller;

import model.Book;
import model.CartItem;
import model.Member;
import model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.BookService;
import service.OrderService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/orders")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private BookService bookService;

	@GetMapping("/member/{memberId}")
	public String getOrdersByMemberId(@PathVariable int memberId, Model model) {
		List<Order> orderList = orderService.getOrdersByMemberId(memberId);
		model.addAttribute("orders", orderList);
		return "user/member_orders";
	}

	@PostMapping("/buyNow")
	public String buyNow(@RequestParam("bookId") int bookId, @RequestParam("quantity") int quantity,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/member/loginform";
		}

		Book book = bookService.getBookById(bookId);
		if (book == null) {
			redirectAttributes.addFlashAttribute("errorMsg", "책 정보를 찾을 수 없습니다.");
			return "redirect:/books";
		}

		Order order = new Order();
		order.setBookId(book.getId());
		order.setQuantity(quantity);
		order.setBook(book);
		order.setMemberId(loginUser.getId());
		order.setTotalPrice(book.getPrice() * quantity);
		order.setOrderDate(new Date());

		session.setAttribute("order", order);

		return "redirect:/orders/payment";
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

		List<Order> orders = new ArrayList<>();
		for (CartItem cartItem : cartMap.values()) {
			Order order = new Order();
			order.setBookId(cartItem.getBook().getId());
			order.setQuantity(cartItem.getQuantity());
			order.setOrderDate(new Date());
			order.setBook(cartItem.getBook());
			order.setTotalPrice(cartItem.getQuantity() * cartItem.getBook().getPrice());
			order.setMemberId(loginUser.getId());
			orders.add(order);
		}

		session.setAttribute("orders", orders);

		return "redirect:/orders/payment";
	}

	@GetMapping("/payment")
	public String showPaymentPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Order order = (Order) session.getAttribute("order");
		List<Order> orders = (List<Order>) session.getAttribute("orders");
		Member loginUser = (Member) session.getAttribute("loginUser");

		if ((order == null && (orders == null || orders.isEmpty())) || loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMsg", "주문 또는 사용자 정보가 없습니다.");
			return "redirect:/cart";
		}

		if (order != null) {
			model.addAttribute("order", order);
		}

		if (orders != null && !orders.isEmpty()) {
			model.addAttribute("orders", orders);
			int totalAmount = 0;
			for (Order o : orders) {
				totalAmount += o.getTotalPrice();
			}
			model.addAttribute("totalAmount", totalAmount);
		}

		model.addAttribute("loginUser", loginUser);
		return "user/payment";
	}

	@PostMapping("/confirm")
	public String confirmOrder(HttpSession session, RedirectAttributes redirectAttributes) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/member/loginform";
		}

		Order singleOrder = (Order) session.getAttribute("order");
		List<Order> orderList = (List<Order>) session.getAttribute("orders");

		if (singleOrder == null && (orderList == null || orderList.isEmpty())) {
			redirectAttributes.addFlashAttribute("errorMsg", "주문 정보가 없습니다.");
			return "redirect:/cart";
		}

		if (singleOrder != null) {
			orderService.insertOrder(singleOrder);
		}

		if (orderList != null && !orderList.isEmpty()) {
			for (Order order : orderList) {
				orderService.insertOrder(order);
			}
		}

		session.removeAttribute("order");
		session.removeAttribute("orders");
		session.removeAttribute("cart");

		redirectAttributes.addFlashAttribute("successMsg", "결제 되었습니다.");
		return "redirect:/orders/member/" + loginUser.getId();
	}
}
