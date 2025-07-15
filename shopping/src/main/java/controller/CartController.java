	package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import model.CartItem;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/cart")
public class CartController {

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        int total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }
        int discount = (int)(total * 0.1);
        int finalTotal = total - discount;

        model.addAttribute("cart", cart);
        model.addAttribute("total", total);
        model.addAttribute("discount", discount);
        model.addAttribute("finalTotal", finalTotal);

        return "cart"; // /WEB-INF/views/cart.jsp
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam String title,
                             @RequestParam int quantity,
                             @RequestParam int price,
                             HttpSession session) {

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getTitle().equals(title)) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(title, quantity, price));
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }
}
