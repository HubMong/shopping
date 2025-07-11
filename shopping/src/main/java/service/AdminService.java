package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.AdminMapper;
import model.AddBooks;
import model.AdminMainList;



@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;
	
	public AdminService() {
		System.out.println("service 생성");
	}
	
	public List<AdminMainList> getAdminList() {
		return mapper.getAdminList();
	}

	public void save(AddBooks book) {
		mapper.save(book);
	}
}
