package controller;

import model.Book;
import model.Review;
import model.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.BookService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(produces = MediaType.TEXT_HTML_VALUE + ";charset=UTF-8")
public class BookController {

    @Autowired
    private BookService bookService;

    // 책 목록
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

    // 책 상세 + 리뷰 목록
    @GetMapping("/books/{id}")
    public String viewBook(@PathVariable("id") int id, Model model, HttpSession session) {
        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);

        List<Review> reviews = bookService.getReviewsByBookId(id);
        model.addAttribute("reviews", reviews);

        // 평균 평점 계산
        Double avg = bookService.getAverageScore(id); // bookService에서 평균 평점 계산
        Integer intScore = avg != null ? avg.intValue() : 0; // 소수점 버리고 정수로
        model.addAttribute("avgScore", intScore);

        // 로그인 여부 체크
        Member loginUser = (Member) session.getAttribute("loginUser");
        model.addAttribute("loggedIn", loginUser != null);

        return "user/bookDetail";
    }


    // 리뷰 작성 (로그인 필요)
    @PostMapping("/books/{bookId}/review")
    public String addReview(@PathVariable int bookId,
                            @RequestParam int score,
                            @RequestParam String content,
                            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/loginform"; // 로그인 안 됐으면 로그인 페이지
        }

        Review review = new Review();
        review.setBookId(bookId);
        review.setMemberId(loginUser.getId()); // 세션에서 가져온 memberId
        review.setScore(score);
        review.setContent(content);

        bookService.addReview(review);

        return "redirect:/books/" + bookId;
    }

    // 리뷰 삭제 (로그인 필요, 작성자 본인만 삭제 가능)
    @PostMapping("/books/{bookId}/review/{id}/delete")
    public String deleteReview(@PathVariable int bookId,
                               @PathVariable int id,
                               HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/member/loginform"; // 로그인 안 됐으면 로그인 페이지
        }

        Review review = bookService.getReviewById(id);
        if (review != null && review.getMemberId() == loginUser.getId()) {
            bookService.deleteReview(id);
        }

        return "redirect:/books/" + bookId;
    }

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "user/login"; // user/login.jsp
    }
}
