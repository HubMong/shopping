package mapper;

import model.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MemberMapper {

    @Select("SELECT * FROM member WHERE id = #{id}")
    Member selectById(int id);

    @Select("SELECT * FROM member")
    List<Member> selectAll();

    @Insert("INSERT INTO member (user_id, password, name, phone, address, created_at) " +
            "VALUES (#{userId}, #{password}, #{name}, #{phone}, #{address}, CURRENT_DATE)")
    int insert(Member member);

    @Update("UPDATE member SET user_id = #{userId}, password = #{password}, " +
            "name = #{name}, phone = #{phone}, address = #{address} WHERE id = #{id}")
    int update(Member member);

    @Delete("DELETE FROM member WHERE id = #{id}")
    int delete(int id);

    @Select("SELECT * FROM member WHERE phone = #{phone}")
    Member selectByHp(String hp);
    
    @Select("SELECT * FROM member WHERE user_id = #{userId}")
    Member selectByUserId(String userId);

}
