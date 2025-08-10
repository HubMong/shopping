package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import model.Order;

public interface OrderMapper {

    @Select("SELECT * FROM ORDERS WHERE member_id = #{memberId}")
    List<Order> selectByMemberId(int memberId);

    @Select("SELECT * FROM ORDERS")
    List<Order> selectAll();

    @Insert("INSERT INTO ORDERS (id, member_id, book_id, quantity, total_price, order_date) " +
            "VALUES (ORDERS_SEQ.NEXTVAL, #{memberId}, #{bookId}, #{quantity}, #{totalPrice}, CURRENT_DATE)")
    int insert(Order order);

    @Delete("DELETE FROM ORDERS WHERE id = #{id}")
    int delete(int id);

    @Select("SELECT * FROM ORDERS WHERE TO_CHAR(id) LIKE '%' || #{keyword} || '%' OR TO_CHAR(book_id) LIKE '%' || #{keyword} || '%'")
    List<Order> search(String keyword);




}