package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Book;

@Mapper
public interface AdminMapper {
    
	@Select("select * from books")
	public List<Book> getBookList();
	
	@Insert("insert into books (id, title, author, content, price, imagePath) "
			+ "values (books_seq.NEXTVAL, #{title}, #{author}, #{content}, #{price}, #{imagePath})")
	public int save(Book book);
	
	@Select("select * from books where id = #{id}")
	public Book getBook(int id);
	
	@Update("update books set title=#{title}, author=#{author}, content=#{content}, "
			+ "price=#{price}, imagePath=#{imagePath} where id=#{id}")
	public void update(Book book);
	
	@Delete("delete from books where id=#{id}")
	public void delete(int id);
	
	
}
