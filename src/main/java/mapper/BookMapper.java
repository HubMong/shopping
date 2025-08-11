package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Book;
@Mapper
public interface BookMapper {

    @Select("SELECT id, title, author, price, description, image, stock FROM book WHERE id = #{id}")
    Book selectBookById(int id);

    @Select("SELECT id, title, author, price, description, image, stock FROM book")
    List<Book> selectAllBooks();

    @Select("SELECT id, title, author, price, description, image, stock FROM book WHERE title LIKE '%' || #{keyword} || '%' OR author LIKE '%' || #{keyword} || '%'")
    List<Book> searchBooks(String keyword);

    @Insert("INSERT INTO book (title, author, price, description, image, stock) " +
            "VALUES (#{title}, #{author}, #{price}, #{description}, #{image}, #{stock})")
    int insert(Book book);

    @Update("UPDATE book SET title = #{title}, author = #{author}, price = #{price}, " +
            "description = #{description}, image = #{image}, stock = #{stock} WHERE id = #{id}")
    int update(Book book);

    @Delete("DELETE FROM book WHERE id = #{id}")
    int delete(int id);
}
