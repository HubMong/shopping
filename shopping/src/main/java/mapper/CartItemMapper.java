package mapper;

import model.CartItem;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CartItemMapper {

	
    @Select("SELECT * FROM cartitem WHERE historyId = #{historyId}")
    List<CartItem> selectByOrderHistory(int historyId);
    
    @Insert("INSERT INTO cartitem (id, memberId, bookId, historyId, quantity, price) VALUES (cartitem_seq.nextval, #{memberId}, #{bookId}, #{historyId}, #{quantity}, #{price})")
    int insert(CartItem cartItem);

    @Update("UPDATE cartitem set memberId=#{memberId}, bookId=#{bookId}, historyId=#{historyId}, quantity=#{quantity}, price=#{price} where id=#{id}")
    int updateById(CartItem cartItem);
	
    @Delete("DELETE FROM cartitem WHERE id = #{id}")
    int deleteById(int id);
    
    @Delete("DELETE FROM cartitem WHERE memberId = #{memberId}")
    int deleteByMemberId(int memberId);
    
    @Delete("DELETE FROM cartitem WHERE historyId = #{historyId}")
    int deleteByOrderHistoryId(int historyId);

}

/*	
   create table cartitem (
  	id number,
    memberId number references member(id),
    bookId number references book(id),
    historyId number references orderhistory(id),
    quantity number,
 	price number);
 */