package model;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class PageList {
	private int currentPage;	//현재페이지
	private int totalCount;		//전체 글의 수	
	private int pagePerCount=10;//페이지당 글의 수
	private int totalPage;		//전체 페이지 
	
	private int startPage;		//네비게이트 시작번호
	private int endPage;		//네비게이트 끝 번호
	private boolean isPre;		//네비게이트 이전표시 여부 getPre(), setPre() -> 
	private boolean isNext;		//네비게이트 다음표시 여부
	
	List<Book> booklist;			//책 정보 페이지 리스트 
	List<Member> memberlist;		//회원 정보 페이지 리스트 
	List<OrderItem> orderlist;			//주문 정보 페이지 리스트 
}
