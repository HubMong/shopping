package service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import mapper.AdminMapper;
import model.Book;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	public List<Book> getBookList() {
		return mapper.getBookList();
	}
	
	public void save(Book book, MultipartFile file) {
		String path="C:/Users/85277/Documents/workspace-sts3/shopping/src/main/webapp/images/"; //파일 저장 위치 지정
		String filename=file.getOriginalFilename();
		String fullname=path+filename;

		try {
			file.transferTo(new File(fullname));
		}catch(Exception e) {
			e.printStackTrace();
		}
		mapper.save(book);
	}
}
