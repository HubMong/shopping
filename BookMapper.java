package mapper; 
import java.util.List; 
import org.apache.ibatis.annotations.*; 
import model.Book; import model.Review;
@Mapper
public interface BookMapper {

    // 책
    @Select("SELECT id, title, author, price, description, image, stock FROM book WHERE id = #{id}")
    Book selectBookById(int id);

    @Select("SELECT id, title, author, price, description, image, stock FROM book")
    List<Book> selectAllBooks();

    @Select("SELECT id, title, author, price, description, image, stock " +
            "FROM book WHERE title LIKE '%' || #{keyword} || '%' OR author LIKE '%' || #{keyword} || '%'")
    List<Book> searchBooks(String keyword);

    @Insert("INSERT INTO book (title, author, price, description, image, stock) " +
            "VALUES (#{title}, #{author}, #{price}, #{description}, #{image}, #{stock})")
    int insert(Book book);

    @Update("UPDATE book SET title = #{title}, author = #{author}, price = #{price}, " +
            "description = #{description}, image = #{image}, stock = #{stock} WHERE id = #{id}")
    int update(Book book);

    @Delete("DELETE FROM book WHERE id = #{id}")
    int delete(int id);

    // 리뷰
    @Select("SELECT r.id, r.book_id AS bookId, r.member_id AS memberId, " +
            "r.score, r.content, r.wrote_on AS wroteOn, m.name AS memberName " +
            "FROM review r " +
            "JOIN member m ON r.member_id = m.id " +
            "WHERE r.book_id = #{bookId} " +
            "ORDER BY r.wrote_on DESC")
    List<Review> getReviewsByBookId(int bookId);

    @Insert("INSERT INTO review (id, book_id, member_id, score, content, wrote_on) " +
            "VALUES (review_seq.NEXTVAL, #{bookId}, #{memberId}, #{score}, #{content}, SYSDATE)")
    int insertReview(Review review);

    @Update("UPDATE review SET score = #{score}, content = #{content} WHERE id = #{id}")
    int updateReview(Review review);

    @Delete("DELETE FROM review WHERE id = #{id}")
    int deleteReview(int id);
    
    @Select("SELECT id FROM member WHERE username = #{username}")
    int findIdByUsername(String username);

    // 추가: 특정 리뷰 조회 (작성자 확인용)
    @Select("SELECT id, book_id AS bookId, member_id AS memberId, score, content, wrote_on AS wroteOn " +
            "FROM review WHERE id = #{id}")
    Review selectReviewById(int id);
}
