package mapper;

import java.util.List;
import model.Book;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
@Mapper
public interface BookMapper {

    @Select("SELECT id, title, author, price, content, imagePath FROM books WHERE id = #{id}")
    Book selectBookById(int id);
    
    @Select("SELECT id, title, author, price, content, imagePath FROM books")
    List<Book> selectAllBooks();
    
    @Select("SELECT id, title, author, price, content, imagePath FROM books WHERE id <= 5")
    List<Book> selectMysteryBooks();
    
    @Select("SELECT id, title, author, price, content, imagePath FROM books WHERE id > 5")
    List<Book> selectBestsellerBooks();
    
    @Select("SELECT id, title, author, price, content, imagePath FROM books WHERE lower(title) LIKE '%' || lower(#{keyword}) || '%' OR lower(author) LIKE '%' || lower(#{keyword}) || '%'")
    List<Book> searchBooks(String keyword);
}
