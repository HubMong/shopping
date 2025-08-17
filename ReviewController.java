package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import model.review;
import service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService service;
	
	@PostMapping("/add")
	public String addReview(@ModelAttribute review review) {		
		service.save(review);		
		return "redirect:/books/"+review.getBookId();
	}
	
	@PostMapping("/delete")
	public String deleteReview(@RequestParam int id, @RequestParam int bookId) {
		service.deleteById(id);
		return "redirect:/books/"+bookId;
	}
	
	@GetMapping("/edit")
	public String editReviewPage(@RequestParam int id, Model model) {
		review review = service.getReviewById(id);
		model.addAttribute("review", review);
		
		return "user/reviewEditform";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute review review) {		
		service.update(review);
		return "redirect:/books/"+review.getBookId();
	}
	
}
