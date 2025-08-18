package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import model.Book;
import model.Member;
import model.Review;
import service.BookService;
import service.MemberService;

@Controller
@RequestMapping(produces = MediaType.TEXT_HTML_VALUE + ";charset=UTF-8")
public class BookController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private MemberService memberService;
	
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
	public String viewBook(@PathVariable("id") int id, Model model, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		model.addAttribute("loginUser", loginUser);
		
		Book book = bookService.getBookById(id);
		List<Review> reviewList = bookService.getReviewsByBook(id);  
		for (Review review : reviewList) {
		    Member member = memberService.selectById(review.getMemberId());
		    review.setMember(member);
		}
		int reviewCount = bookService.getCountByBookId(id);
		int reviewSum = bookService.getSumByBookId(id);
		float reviewAverage = 0.0f;
		
		if (reviewCount > 0) {
		    reviewAverage = (float) reviewSum / (float) reviewCount;
		}
		
		int fullStars = (int) reviewAverage;
		boolean halfStar = (reviewAverage - fullStars) >= 0.5;

		model.addAttribute("fullStars", fullStars);
		model.addAttribute("halfStar", halfStar);
		model.addAttribute("emptyStars", 5 - fullStars - (halfStar ? 1 : 0));
		
		model.addAttribute("book", book);
		model.addAttribute("reviewList", reviewList);        
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("reviewAverage", reviewAverage);
		return "user/bookDetail";
	}

	@PostMapping("review/add")
	public String addReview(@RequestParam("rating") int rating,
            @RequestParam("content") String content,
            @RequestParam("id") int id,
            @SessionAttribute("loginUser") Member loginUser) {		
		
	    Review review = new Review();
	    review.setBookId(id);
	    review.setScore(rating);
	    review.setContent(content);
	    review.setMemberId(loginUser.getId());
	    
	    bookService.save(review);
		
		return "redirect:/books/"+review.getBookId();
	}

	@PostMapping("review/delete")
	public String deleteReview(@RequestParam int id, @RequestParam int bookId) {
		bookService.deleteById(id);
		return "redirect:/books/"+bookId;
	}

	@GetMapping("review/edit")
	public String editReviewPage(@RequestParam int id, @RequestParam int bookId, 
			HttpSession session, Model model) {
		Review review = bookService.getReviewById(id);
		model.addAttribute("review", review);
		return "user/reviewEditform";
	}
	
	@PostMapping("review/update")
	public String update(@ModelAttribute Review review) {		
		bookService.update(review);
		return "redirect:/books/"+review.getBookId();
	}
}