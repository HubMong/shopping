package mapper;

import model.CartItem;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CartItemMapper {

    @Select("SELECT * FROM cart WHERE member_id = #{memberId}")
    List<CartItem> selectByMemberId(int memberId);

    @Insert("INSERT INTO cart (member_id, book_id, quantity, added_at) " +
            "VALUES (#{memberId}, #{bookId}, #{quantity}, CURRENT_DATE)")
    int insert(CartItem cartItem);

    @Update("UPDATE cart SET quantity = #{quantity} WHERE id = #{id}")
    int update(CartItem cartItem);

    @Delete("DELETE FROM cart WHERE id = #{id}")
    int delete(int id);

    @Delete("DELETE FROM cart WHERE member_id = #{memberId}")
    int deleteByMemberId(int memberId);
}
