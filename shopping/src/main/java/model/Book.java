package model;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class Book {
    private int id;
    private String title;
    private String author;
    private int price;
    private String description;	
    private String image;
    private int stock; 
    private int salesVolumn;
    private Member member;
    private List<review> reviewList;
}
