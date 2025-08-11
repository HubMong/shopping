package controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import model.Book;
import service.BookService;

@Controller
@RequestMapping(produces = MediaType.TEXT_HTML_VALUE + ";charset=UTF-8")
public class BookController {

    @Autowired
    private BookService bookService;
    
    @GetMapping({"/", "/books"})
    public String home(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Book> bookList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            bookList = bookService.searchBooks(keyword);
            model.addAttribute("searchKeyword", keyword);
        } else {
            bookList = bookService.getAllBooks();
        }
        model.addAttribute("bookList", bookList);
        
        return "user/list";
    }

    @GetMapping("/books/{id}")
    public String viewBook(@PathVariable("id") int id, Model model) {
        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);
        return "user/bookDetail";
    }
}