package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    private int id;
    private int memberId;
    // private int bookId;
    private int quantity;
    // private Date addedAt;
    private int price;
    private int historyId;
    private Book book;
}
