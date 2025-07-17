package model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Book {
    private int id;
    private String title;
    private String author;
    private int price;
    private String content;
    private String imagePath;

    // ID 기반으로 책 카테고리 판별
    public String getCategory() {
        if (id <= 5) {
            return "mystery";
        } else {
            return "bestseller";
        }
    }

    // ID 기반으로 베스트셀러 여부 판별
    public boolean isBestseller() {
        return id > 5;
    }
}
