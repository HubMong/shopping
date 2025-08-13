package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.Book;
import model.Member;
import model.Order;
import service.AdminService;
import service.BookService;
import service.MemberService;
import service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminservice;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private OrderService orderservice;
	
	@Autowired
	private BookService bookservice;

	@RequestMapping("books")
	public ModelAndView adminMainlist(ModelAndView mv, 
	        @RequestParam(value = "keyword", required = false) String keyword) {
	    if (keyword == null || keyword.trim().isEmpty()) {
	        mv.addObject("books", adminservice.getBookList());
	    } else {
	        mv.addObject("books", adminservice.searchBooks(keyword));
	    }
	    mv.addObject("keyword", keyword);  // 검색어 유지용
	    mv.setViewName("admin/adminbooklist");
        mv.addObject("page", "books");
	    return mv;
	}

	@RequestMapping("addbook")
	public String addBook() {
		return "admin/addbookform";
	}

	@PostMapping("save")
	public String save(@RequestParam("title") String title, @RequestParam("author") String author,
			@RequestParam("price") int price, @RequestParam("description") String description,
			@RequestParam("image") MultipartFile file, @RequestParam("stock") int stock) {
		Book book = new Book();
		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setPrice(price);
		book.setStock(stock);

		adminservice.save(book, file);

		return "redirect:/admin/books";
	}

	@GetMapping("books/detail")
	public ModelAndView showBookDetail(ModelAndView mv, @RequestParam("id") int id) {
	    // 책 정보를 조회
	    Book book = adminservice.getBook(id);
	    
	    // 책 정보를 모델에 추가
	    mv.addObject("book", book);
	    
	    // 책 상세보기 페이지로 이동
	    mv.setViewName("admin/adminbookdetail");  // 이 페이지로 이동해야 책 상세 정보를 볼 수 있습니다.
	    return mv;
	}

    @GetMapping("books/edit")
    public ModelAndView showEditForm(ModelAndView mv, int id) {
    	mv.addObject("book", adminservice.getBook(id));
    	mv.setViewName("admin/adminbookedit");
    	return mv;
    }

    @PostMapping("books/update")
    public String processEdit(@RequestParam("id") int id, @RequestParam("title") String title, 
    		@RequestParam("author") String author,
			@RequestParam("price") int price, @RequestParam("description") String description,
			@RequestParam("image") MultipartFile file, 
			@RequestParam("originImage") String originImage,@RequestParam("stock") int stock) {
    	
		Book book = new Book();
		book.setId(id);
		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setPrice(price);
		book.setStock(stock);
		
	    if (!file.isEmpty()) {
	        // 새 이미지가 업로드된 경우 → 새 이미지 저장
	    } else {
	        // 이미지 업로드 안 했으면 → 기존 이미지 유지
	        book.setImage(originImage);
	    }
		
    	System.out.println(book);
    	adminservice.update(book, file);
	
    	return "redirect:/admin/books/detail?id=" + book.getId();
    }

    @PostMapping("books/delete")
    public String deleteBook(int id) {
    	adminservice.delete(id);
        return "redirect:/admin/books"; // 삭제 후 목록 페이지로 이동
    }
    
//	멤버 관리자
    
    @RequestMapping("adminmemberlist")
    public ModelAndView adminMemberlist(ModelAndView mv, 
            @RequestParam(value = "keyword", required = false) String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            mv.addObject("members", memberservice.getAllMembers());
        } else {
            mv.addObject("members", memberservice.searchMembers(keyword));
        }
        mv.addObject("keyword", keyword);
        mv.setViewName("admin/adminmemberlist");
        mv.addObject("page", "members");
        return mv;
    }
	
	@RequestMapping("adminmemberlist/edit")
	public ModelAndView adminMemberEdit(ModelAndView mv, String userId) {
		mv.addObject("member", memberservice.selectByUserId(userId));
		mv.setViewName("admin/adminmemberedit");
		System.out.println("값 : " + memberservice.selectByUserId(userId));
		return mv;
	}

	@RequestMapping("adminmemberlist/update")
	public String adminMemberUpdate(@RequestParam("id") int id, @RequestParam("userId") String userId,
			@RequestParam("password") String password, @RequestParam("name") String name,
			@RequestParam("phone") String phone, @RequestParam("address") String address) {
		Member member = new Member();
		member.setId(id);
		member.setUserId(userId);
		member.setPassword(password);
		member.setName(name);
		member.setPhone(phone);
		member.setAddress(address);
		
		return "redirect:/admin/adminmemberlist";
	}
	
	@RequestMapping("adminmemberlist/delete")
	public String adminMemberDelete(String userId) {
		memberservice.remove(userId);
		return "redirect:/admin/adminmemberlist";
	}
	
//  관리자 주문
	
	@RequestMapping("adminorderlist")
	public ModelAndView adminOrderlist(ModelAndView mv, 
	        @RequestParam(value = "keyword", required = false) String keyword) {
	    if (keyword == null || keyword.trim().isEmpty()) {
	        mv.addObject("orders", orderservice.getAllOrders());
	    } else {
	        mv.addObject("orders", orderservice.searchOrders(keyword));
	    }
	    mv.addObject("keyword", keyword);
	    
	    mv.addObject("page", "orders");
	    mv.setViewName("admin/adminorderlist");
	    return mv;
	}
	
	@RequestMapping("adminorderlist/detail")
	public ModelAndView adminOrderDetail(ModelAndView mv, int id) {
	    // 주문 ID로 주문 정보 조회
	    Order order = orderservice.getOrderById(id);
	    mv.addObject("order", order);  // 주문 정보를 모델에 추가
	    mv.setViewName("admin/adminorderdetail");  // 주문 상세 페이지로 이동
	    return mv;
	}

	@RequestMapping("adminorderlist/delete")
	public String adminOrderDelete(String userId) {
		memberservice.remove(userId);
		return "redirect:/admin/adminorderlist";
	}
}
