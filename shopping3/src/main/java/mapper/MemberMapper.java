package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;

@Mapper
public interface MemberMapper {

	// 회원 가입
	@Insert("INSERT INTO members (id, password, name, email, hp, address) " +
			"VALUES (#{id}, #{password}, #{name}, #{email}, #{hp}, #{address})")
	public int insert(Member member);

	// 아이디로 회원 조회
	@Select("SELECT id, password, name, email, hp, address FROM members WHERE id = #{id}")
	public Member selectById(String id);

	// 이메일로 회원 조회
	@Select("SELECT id, password, name, email, hp, address FROM members WHERE email = #{email}")
	public Member selectByEmail(String email);

	// 전화번호로 회원 조회
	@Select("SELECT id, password, name, email, hp, address FROM members WHERE hp = #{hp}")
	public Member selectByHp(String hp);

	// 전체 회원 조회
	@Select("SELECT id, password, name, email, hp, address FROM members")
	public List<Member> selectAll();

	// 회원 정보 수정
	@Update("UPDATE members SET password = #{password}, name = #{name}, email = #{email}, hp = #{hp}, address = #{address} " +
			"WHERE id = #{id}")
	public int update(Member member);

	// 회원 삭제
	@Delete("DELETE FROM members WHERE id = #{id}")
	public int delete(String id);
}


