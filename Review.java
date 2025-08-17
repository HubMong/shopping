package model;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString

public class Review {

    private int id;         // 리뷰 ID
    private int bookId;     // 책 ID
    private int memberId;   // 회원 ID
    private String memberName; // 회원 이름 추가
    private int score;      // 평점 (1~5)
    private String content; // 내용
    private Date wroteOn;   // 작성일
}

