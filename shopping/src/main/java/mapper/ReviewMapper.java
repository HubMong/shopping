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
	
	@Insert("INSERT into review (id, book_id, member_id, score, content, wrote_on) values (review_seq.nextval, #{bookId}, #{memberId}, #{score}, #{content}, sysdate)")
	public int save(Review review);
	
	@Select("SELECT * from review where id=#{id}")
	public Review selectById(int id);
	
	@Select("SELECT * from review where book_id=#{bookId} order by id desc")
	public List<Review> selectByBookId(int bookId);
	
	@Select("SELECT * from review where member_id=#{memberId} order by id desc")
	public List<Review> selectByMemberId(int memberId);
	
	@Select("SELECT count(*) from review where book_id=#{bookId}")
	public int countByBookId(int bookId);
	
	@Select("SELECT NVL(SUM(score), 0) from review where book_id=#{bookId}")
	public int sumScoreByBookId(int bookId);
	
	@Update("UPDATE review set book_id=#{bookId}, member_id=#{memberId}, score=#{score}, content=#{content}, wrote_on=#{wroteOn} where id=#{id}")
	public int update(Review review);
	
	@Delete("DELETE from review where id=#{id}")
	public int deleteById(int id);
	
	@Delete("DELETE from review where book_id=#{bookId}")
	public int deleteByBookId(int bookId);
	
	@Delete("DELETE from review where member_id=#{memberId}")
	public int deleteByMemberId(int memberId);
}
