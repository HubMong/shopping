package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import model.Book;

@Mapper
public interface AdminMapper {
    
	@Select("select * from book")
	public List<Book> getBookList();
	
	@Insert("insert into book (book_id, title, content, price, imagepath) "
			+ "values (book_seq.NEXTVAL, #{title}, #{content}, #{price}, #{imagepath})")
	public int save(Book book);
}
