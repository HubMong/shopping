package model;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class AdminMainList {
	private int bookId;
	private String title;
	private String image;
}
