package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Review;

@Mapper
public interface ReviewMapper {

    // INSERT
    @Insert({
        "INSERT INTO review (id, book_id, member_id, score, content, wrote_on)",
        "VALUES (review_seq.nextval, #{bookId}, #{memberId}, #{score}, #{content}, sysdate)"
    })
    int save(Review review);

    // SELECT
    @Select("SELECT * FROM review WHERE id = #{id}")
    Review selectById(int id);

    @Select("SELECT * FROM review WHERE book_id = #{bookId} ORDER BY id DESC")
    List<Review> selectByBookId(int bookId);

    @Select("SELECT * FROM review WHERE member_id = #{memberId} ORDER BY id DESC")
    List<Review> selectByMemberId(int memberId);

    @Select("SELECT COUNT(*) FROM review WHERE book_id = #{bookId}")
    int countByBookId(int bookId);

    @Select("SELECT NVL(SUM(score), 0) FROM review WHERE book_id = #{bookId}")
    int sumScoreByBookId(int bookId);

    // UPDATE (안전: 본인만, 내용/별점만)
    @Update({
        "UPDATE review",
        "   SET score = #{score},",
        "       content = #{content}",
        " WHERE id = #{id}",
        "   AND member_id = #{memberId}"
    })
    int updateByOwner(Review review);

    // DELETE
    @Delete("DELETE FROM review WHERE id = #{id}")
    int deleteById(int id);

    @Delete("DELETE FROM review WHERE book_id = #{bookId}")
    int deleteByBookId(int bookId);

    @Delete("DELETE FROM review WHERE member_id = #{memberId}")
    int deleteByMemberId(int memberId);
}
