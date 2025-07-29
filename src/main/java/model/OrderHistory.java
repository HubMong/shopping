package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderHistory {
    private int id;
    private int memberId;
    private int bookId;
    private int quantity;
    private int totalPrice;
    private Date orderDate;
}
