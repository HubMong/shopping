package controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@RequestMapping("test")
	public ModelAndView test(ModelAndView mv) {
		mv.addObject("books", service.getBookList());
		mv.setViewName("admin/adminupgrade");
		System.out.println(mv);
		return mv;
	}
	
	@RequestMapping("books")
	public ModelAndView adminMainlist(ModelAndView mv) {
		mv.addObject("books", service.getBookList());
		mv.setViewName("admin/adminlist");
		System.out.println(mv);
		return mv;
	}

	@RequestMapping("addbook")
	public String addBook() {
		return "admin/addbookform";
	}

	@PostMapping("save")
	public String save(@RequestParam("title") String title, @RequestParam("author") String author,
			@RequestParam("price") int price, @RequestParam("content") String content,
			@RequestParam("imagePath") MultipartFile file) {
		Book book = new Book();
		book.setTitle(title);
		book.setAuthor(author);
		book.setContent(content);
				book.setPrice(price);

		service.save(book, file);

		return "redirect:/admin/books";
	}

	@GetMapping("books/detail")
	public ModelAndView showBookDetail(ModelAndView mv, int id) {
		mv.addObject("book", service.getBook(id));
		mv.setViewName("admin/admindetail");
		return mv;
	}

    @GetMapping("books/edit")
    public ModelAndView showEditForm(ModelAndView mv, int id) {
    	mv.addObject("book", service.getBook(id));
    	mv.setViewName("admin/adminedit");
    	return mv;
    }

    @PostMapping("books/update")
    public String processEdit(@RequestParam("id") int id, @RequestParam("title") String title, 
    		@RequestParam("author") String author,
			@RequestParam("price") int price, @RequestParam("content") String content,
			@RequestParam("imagePath") MultipartFile file, 
			@RequestParam("originImage") String originImage) {
    	
		Book book = new Book();
		book.setId(id);
		book.setTitle(title);
		book.setAuthor(author);
		book.setContent(content);
		book.setPrice(price);
		
	    if (!file.isEmpty()) {
	        // 새 이미지가 업로드된 경우 → 새 이미지 저장
	    } else {
	        // 이미지 업로드 안 했으면 → 기존 이미지 유지
	        book.setImagePath(originImage);
	    }
		
    	System.out.println(book);
		service.update(book, file);
	
    	return "redirect:/admin/books/detail?id=" + book.getId();
    }

    @PostMapping("books/delete")
    public String deleteBook(int id) {
    	service.delete(id);
        return "redirect:/admin/books"; // 삭제 후 목록 페이지로 이동
    }

}
