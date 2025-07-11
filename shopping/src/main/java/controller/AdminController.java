package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.AddBooks;
import service.AdminService;


@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService service;

	public AdminController() {
		System.out.println("controller");
	}

	@RequestMapping("adminmainlist")
	public ModelAndView adminMainlist(ModelAndView mv) {
		mv.addObject("adminmainlist", service.getAdminList());
		mv.setViewName("adminlist");
		System.out.println(mv);
		return mv;
	}

	@RequestMapping("addbook")
	public String addBook(AddBooks book) {
		return "addbookform";
	}

	@PostMapping("save")
	public String save(@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("price") int price,
			@RequestParam("image") MultipartFile image,
			HttpServletRequest request) {

		String uploadPath = request.getServletContext().getRealPath("/images");
		String fileName = image.getOriginalFilename();

		try {
			if (fileName != null && !fileName.isEmpty()) {
				File saveFile = new File(uploadPath, fileName);
				image.transferTo(saveFile);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		AddBooks book = new AddBooks();
		book.setTitle(title);
		book.setContent(content);
		book.setPrice(price);
		book.setImage(fileName); // DB에는 파일 이름만 저장
		
		System.out.println("입력값 : " + book);
		service.save(book);
		return "redirect:/admin/adminmainlist";
	}
}
