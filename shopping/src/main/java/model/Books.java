package model;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class Books {
	private int id;
	private String title;
	private String author;
	private int price;
	private String content;
	private String imagePath;
}
