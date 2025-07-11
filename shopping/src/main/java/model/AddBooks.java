package model;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class AddBooks {
	private int bookId;
	private String title;
	private String content;
	private int price;
	private String image;
}
