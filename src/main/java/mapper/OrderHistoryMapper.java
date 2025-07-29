package mapper;

import model.OrderHistory;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderHistoryMapper {

    @Select("SELECT * FROM order_history WHERE member_id = #{memberId}")
    List<OrderHistory> selectByMemberId(int memberId);

    @Select("SELECT * FROM order_history")
    List<OrderHistory> selectAll();

    @Insert("INSERT INTO order_history (member_id, book_id, quantity, total_price, order_date) " +
            "VALUES (#{memberId}, #{bookId}, #{quantity}, #{totalPrice}, CURRENT_DATE)")
    int insert(OrderHistory order);
}
