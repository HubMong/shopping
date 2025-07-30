package model;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class Order {
    private int orderId;
    private String memberId;
    private Date orderDate;
    private int totalAmount;
    private List<OrderItem> items;
}