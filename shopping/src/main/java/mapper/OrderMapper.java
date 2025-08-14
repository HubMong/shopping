package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import model.Order;

public interface OrderMapper {

    @Select("SELECT * FROM ORDERS WHERE member_id = #{memberId}")
    public List<Order> selectByMemberId(int memberId);

    @Select("SELECT * FROM ORDERS ORDER BY order_date desc")
    public List<Order> selectAll();

    @Insert("INSERT INTO ORDERS (id, member_id, book_id, quantity, total_price, order_date, transaction_id) " +
            "VALUES (ORDERS_SEQ.NEXTVAL, #{memberId}, #{bookId}, #{quantity}, #{totalPrice}, CURRENT_DATE, #{transactionId})")
    public int insert(Order order);
    
    // 주문 ID로 특정 주문 조회
    @Select("SELECT * FROM ORDERS WHERE id = #{orderId}")
    public Order selectById(int orderId);
    
    @Select("SELECT o.id, o.member_id AS memberId, "
    		+ "o.book_id AS bookId,o.quantity, o.total_price AS totalPrice, o.order_date AS orderDate, "
    		+ "b.id AS b_id, b.title AS b_title,"
    		+ " m.id AS m_id, m.name AS m_name "
    		+ "FROM ORDERS o JOIN BOOK b ON o.book_id = b.id "
    		+ "JOIN MEMBER m ON o.member_id = m.id "
    		+ "WHERE TO_CHAR(o.id) LIKE '%' || #{keyword} || '%' "
    		+ "OR LOWER(b.title) LIKE '%' || #{keyword} || '%' "
    		+ "OR LOWER(m.name) LIKE '%' || #{keyword} || '%' "
    		+ "ORDER BY o.id DESC")
        @Results({
            @Result(property="id", column="id"),
            @Result(property="memberId", column="memberId"),
            @Result(property="bookId", column="bookId"),
            @Result(property="quantity", column="quantity"),
            @Result(property="totalPrice", column="totalPrice"),
            @Result(property="orderDate", column="orderDate"),
            @Result(property="book.id", column="b_id"),
            @Result(property="book.title", column="b_title"),
            @Result(property="member.id", column="m_id"),
            @Result(property="member.name", column="m_name")
        })
    	List<Order> search(String keyword);

}
