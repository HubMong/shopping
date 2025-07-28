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
    private String description;
    private String image;   
}
