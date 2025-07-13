package model;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class AddBook {
	private int book_id;
	private String title;
	private String content;
	private int price;
	private String imagepath;
}
