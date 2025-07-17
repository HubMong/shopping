package model;

import java.util.Date;
import java.util.List;
import lombok.Data;

@Data
public class Order {
    private int orderId;
    private String memberId;
    private Date orderDate;
    private int totalAmount;
    private List<OrderItem> items;
}