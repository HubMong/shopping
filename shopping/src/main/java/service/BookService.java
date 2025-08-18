package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.BookMapper;
import mapper.ReviewMapper;
import model.Book;
import model.Review;

@Service
public class BookService {

    @Autowired
    private BookMapper bookMapper;
    
    @Autowired
    private ReviewMapper reviewMapper;

    public Book getBookById(int id) {
        return bookMapper.selectBookById(id);
    }
    
    public List<Book> getAllBooks() {
        return bookMapper.selectAllBooks();
    }
    
    public List<Book> searchBooks(String keyword) {
        return bookMapper.searchBooks(keyword);
    }
    
    public void updateStock(int bookId, int quantity) {
    	bookMapper.updateStock(bookId, quantity);
    }
    
    public int save(Review review) {
		return reviewMapper.save(review);
	}

	public List<Review> getReviewsByBook(int id) {
		return reviewMapper.selectByBookId(id);
	}

	public int deleteById(int id) {
		return reviewMapper.deleteById(id);
	}

	public Review getReviewById(int id) {
		return reviewMapper.selectById(id);
	}

	public int update(Review review) {
		Review previous = reviewMapper.selectById(review.getId());
		if(review.getBookId() == 0) review.setBookId(previous.getBookId());
		if(review.getContent() == null) review.setContent(previous.getContent());
		if(review.getId() == 0) review.setId(previous.getId());
		if(review.getMemberId() == 0) review.setMemberId(previous.getMemberId());
		if(review.getScore() == 0) review.setScore(previous.getScore());
		if(review.getWroteOn() == null) review.setWroteOn(previous.getWroteOn());
		
		return reviewMapper.update(review);		
	}
	
	public int getCountByBookId(int bookId) {
		return reviewMapper.countByBookId(bookId);
	}
	
	public int getSumByBookId(int bookId) {
		return reviewMapper.sumScoreByBookId(bookId);
	}

	public int updateSalesVolume(Book book) {
		return bookMapper.updateSalesVolume(book);
	}
}
