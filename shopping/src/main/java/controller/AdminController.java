package controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.Book;
import service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService service;

	@RequestMapping("books")
	public ModelAndView adminMainlist(ModelAndView mv) {
		mv.addObject("books", service.getBookList());
		mv.setViewName("adminlist");
		System.out.println(mv);
		return mv;
	}
	
	@RequestMapping("addbook")
	public String addBook() {
		return "addbookform";
	}
 
	@PostMapping("save")
	public String save(@RequestParam("title") String title, @RequestParam("price") int price
			, @RequestParam("content") String content, @RequestParam("imagepath") MultipartFile file) {
		System.out.println(title);
		Book book = new Book();
		book.setTitle(title);
		book.setContent(content);
		book.setPrice(price);
		
		String filename = file.getOriginalFilename(); // 파일 이름 추출
		book.setImagepath(filename); // DB에는 파일 이름만 저장
	
		service.save(book, file);
		
		return "redirect:/admin/books";
	}
}
