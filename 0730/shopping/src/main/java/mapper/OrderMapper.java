 package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import model.Order;

public interface OrderMapper {

    @Select("SELECT * FROM ORDERS WHERE member_id = #{memberId}")
    public List<Order> selectByMemberId(int memberId);

    @Select("SELECT * FROM ORDERS")
    public List<Order> selectAll();

    @Insert("INSERT INTO ORDERS (id, member_id, book_id, quantity, total_price, order_date) " +
         "VALUES (ORDERS_SEQ.NEXTVAL, #{memberId}, #{bookId}, #{quantity}, #{totalPrice}, CURRENT_DATE)")
    public int insert(Order order);
}