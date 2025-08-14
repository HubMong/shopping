package model;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class review {
	private int id;
	private int bookId;
	private int memberId;
	private int score;
	private String content;
	private Date wroteOn;
}
