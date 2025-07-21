package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import model.Book;
import model.CartItem;
import service.BookService;

@Controller
@RequestMapping(produces = MediaType.TEXT_HTML_VALUE + ";charset=UTF-8")
public class CartController {
    
    @Autowired
    private BookService bookService;
    
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        Map<Integer, CartItem> cartMap = getCartMap(session);
        List<CartItem> cartItems = new ArrayList<>(cartMap.values());
        
        int totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getBook().getPrice() * item.getQuantity();
        }
        
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        
        return "user/cart";
    }
    
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("bookId") int bookId, HttpSession session) {
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            return "redirect:/books";
        }
        
        Map<Integer, CartItem> cartMap = getCartMap(session);
        
        if (cartMap.containsKey(bookId)) {
            cartMap.get(bookId).increaseQuantity();
        } else {
            cartMap.put(bookId, new CartItem(book, 1));
        }
        
        session.setAttribute("cart", cartMap);
        
        return "redirect:/cart";
    }
    
    @PostMapping("/cart/update")
    public String updateCart(
            @RequestParam("bookId") int bookId,
            @RequestParam("action") String action,
            HttpSession session) {
        
        Map<Integer, CartItem> cartMap = getCartMap(session);
        
        if (cartMap.containsKey(bookId)) {
            CartItem item = cartMap.get(bookId);
            
            if ("increase".equals(action)) {
                item.increaseQuantity();
            } else if ("decrease".equals(action)) {
                item.decreaseQuantity();
            }
        }
        
        session.setAttribute("cart", cartMap);
        
        return "redirect:/cart";
    }
    
    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam("bookId") int bookId, HttpSession session) {
        Map<Integer, CartItem> cartMap = getCartMap(session);
        
        cartMap.remove(bookId);
        session.setAttribute("cart", cartMap);
        
        return "redirect:/cart";
    }
    
    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCartMap(HttpSession session) {
        Map<Integer, CartItem> cartMap = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cartMap == null) {
            cartMap = new HashMap<>();
            session.setAttribute("cart", cartMap);
        }
        
        return cartMap;
    }
}
