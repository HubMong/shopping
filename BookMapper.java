package mapper;

import model.Book;
import org.apache.ibatis.annotations.Select;

public interface BookMapper {

    @Select("SELECT id, title, author, price, description, cover_url AS coverUrl FROM books WHERE id = #{id}")
    Book selectBookById(int id);

}
