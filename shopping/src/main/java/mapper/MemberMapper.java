package mapper;

import model.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MemberMapper {

	// 추가: id 기준 조회 (userId 외에 숫자 id도 로그인/조회 시 활용 가능)
	@Select("SELECT * FROM member WHERE id = #{id}")
	Member selectById(int id); // 추가: 숫자 id 기준 조회

	// 수정: userId 기준 조회로 변경
	@Select("SELECT * FROM member WHERE user_id = #{userId}")
	Member selectByUserId(String userId);

	@Select("SELECT * FROM member")
	List<Member> selectAll();

	@Insert("INSERT INTO member (id, user_id, password, name, phone, address, created_at, role) "
			+ "VALUES (MEMBER_SEQ.NEXTVAL, #{userId}, #{password}, #{name}, #{phone}, #{address}, CURRENT_DATE, 'USER')")
	int insert(Member member);

	// 추가: userId 기준으로 수정
	@Update("UPDATE member SET password = #{password}, "
			+ "name = #{name}, phone = #{phone}, address = #{address} WHERE user_id = #{userId}")
	int update(Member member);

	// 기존: id 기준 수정
	@Update("UPDATE member SET password = #{password}, name = #{name}, phone = #{phone}, address = #{address} WHERE id = #{id}")
	int updateById(Member member);

	// 수정: userId 기준 삭제
	@Delete("DELETE FROM member WHERE user_id = #{userId}")
	int delete(String userId); // 수정: int id → String userId

	// 기존: id 기준 삭제
	@Delete("DELETE FROM member WHERE id = #{id}")
	int deleteById(int id);

	@Select("SELECT * FROM member WHERE phone = #{phone}")
	Member selectByHp(String phone);

    @Select("SELECT * FROM MEMBER " +
            "WHERE name LIKE '%' || #{keyword} || '%' " +
            "   OR user_id LIKE '%' || #{keyword} || '%'")
    List<Member> searchByKeyword(String keyword);
}