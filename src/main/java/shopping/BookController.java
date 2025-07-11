package shopping;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

@Controller
@RequestMapping("/books")
public class BookController {

    @GetMapping
    public String listBooks(Model model) {
        List<Book> bookList = new ArrayList<>();
        bookList.add(new Book(1, "치유의 빛", 25000, "/resources/images/book1.jpg"));
        bookList.add(new Book(2, "생각의 주도권", 36000, "/resources/images/book2.jpg"));
        bookList.add(new Book(3, "마지네일의", 32000, "/resources/images/book3.jpg"));
        bookList.add(new Book(4, "너무 늦은 시간", 28300, "/resources/images/book4.jpg"));
        bookList.add(new Book(5, "첫 여름, 완주", 23000, "/resources/images/book5.jpg"));
        bookList.add(new Book(6, "소설 보다 여름", 24500, "/resources/images/book6.jpg"));
        bookList.add(new Book(7, "워런 바이블", 34500, "/resources/images/book7.jpg"));
        bookList.add(new Book(8, "소크라테스", 29500, "/resources/images/book8.jpg"));     
        model.addAttribute("bookList", bookList);
        return "list"; // → /WEB-INF/views/list.jsp
    }
}