package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import model.AddBooks;
import model.AdminMainList;

@Mapper
public interface AdminMapper {
	
	@Select("select * from adminmainlist")
	public List<AdminMainList> getAdminList();
	
	
	@Insert("insert into AddBooks (bookId, title, content, price, image) "
	+ "values (add_books_seq.NEXTVAL, #{title}, #{content}, #{price}, #{image})") 
	public void save(AddBooks book);
	
	
}
