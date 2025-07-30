package service;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import mapper.AdminMapper;
import mapper.OrderMapper;
import model.Book;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private ServletContext servletContext;
	
	public List<Book> getBookList() {
		return mapper.getBookList();
	}
	
	public void save(Book book, MultipartFile file) {
		if (file != null && !file.isEmpty()) {
			String path = servletContext.getRealPath("/resources/images/");
			String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			book.setImagePath(filename); // DB에는 고유한 파일 이름 저장
			File uploadDir = new File(path);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			String fullname = path + File.separator + filename;

			try {
				file.transferTo(new File(fullname));
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		mapper.save(book);
	}

	public Book getBook(int id) {
		return mapper.getBook(id);
	}

	public void update(Book book, MultipartFile file) {
		if (file != null && !file.isEmpty()) {
			String path = servletContext.getRealPath("/resources/images/");
			String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			book.setImagePath(filename); // DB에는 고유한 파일 이름 저장
			File uploadDir = new File(path);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			String fullname = path + File.separator + filename;

			try {
				file.transferTo(new File(fullname));
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		mapper.update(book);
	}

	public void delete(int id) {
		orderMapper.deleteOrderItemsByBookId(id); // 해당 책을 참조하는 주문 상품 먼저 삭제
		mapper.delete(id);
	}
}
