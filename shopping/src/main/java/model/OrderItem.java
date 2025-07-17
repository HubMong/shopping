package model;

import lombok.Data;

@Data
public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int bookId;
    private int quantity;
    private int price; // 기존 price 필드 유지

    // 책 정보 추가 (테이블에 직접 저장될 필드)
    private String title;
    private String author;
}