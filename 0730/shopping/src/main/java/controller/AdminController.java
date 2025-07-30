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
	
	@RequestMapping("books")
	public ModelAndView adminMainlist(ModelAndView mv) {
		mv.addObject("books", adminservice.getBookList());
		mv.setViewName("admin/adminbooklist");
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
	public ModelAndView showBookDetail(ModelAndView mv, int id) {
		mv.addObject("book", adminservice.getBook(id));
		mv.setViewName("admin/adminbookdetail");
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
	public ModelAndView adminMemberlist(ModelAndView mv) {
		mv.addObject("members", memberservice.getAllMembers());
		mv.setViewName("admin/adminmemberlist");
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
	public ModelAndView adminOrderlist(ModelAndView mv) {
		mv.addObject("orders", orderservice.getAllOrders());
		mv.setViewName("admin/adminorderlist");
		return mv;
	}
	
	@RequestMapping("adminorderlist/detail")
	public ModelAndView adminOrderDetail(ModelAndView mv, int id) {
		mv.addObject("orders", orderservice.getOrdersByMemberId(id));
		mv.setViewName("admin/adminorderdetail");
		return mv;
	}
/*	
	@RequestMapping("adminorderlist/edit")
	public String adminOrderUpdate(@RequestParam("id") int id, @RequestParam("memberId") int memberId,
			@RequestParam("bookId") int bookId, @RequestParam("quantity") int quantity,
			@RequestParam("totalPrice") int totalPrice) {
		Order order = new Order();
		order.setId(id);
		order.setMemberId(memberId);
		order.setBookId(bookId);
		order.setQuantity(quantity);
		order.setTotalPrice(totalPrice);
		
		return "redirect:/admin/adminorderlist/detail?id=" + order.getId();
	}
*/
	@RequestMapping("adminorderlist/delete")
	public String adminOrderDelete(String userId) {
		memberservice.remove(userId);
		return "redirect:/admin/adminorderlist";
	}
}
