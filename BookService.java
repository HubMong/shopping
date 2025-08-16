package service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mapper.BookMapper;
import model.Book;
import model.Review;

@Service
public class BookService {

    @Autowired
    private BookMapper bookMapper;

    // 책
    public Book getBookById(int id) {
        return bookMapper.selectBookById(id);
    }

    public List<Book> getAllBooks() {
        return bookMapper.selectAllBooks();
    }

    public List<Book> searchBooks(String keyword) {
        return bookMapper.searchBooks(keyword);
    }

    // 리뷰
    public int getMemberIdByUsername(String username) {
        return bookMapper.findIdByUsername(username);
    }

    public List<Review> getReviewsByBookId(int bookId) {
        return bookMapper.getReviewsByBookId(bookId);
    }

    public int addReview(Review review) {
        return bookMapper.insertReview(review);
    }

    public int updateReview(Review review) {
        return bookMapper.updateReview(review);
    }

    public int deleteReview(int id) {
        return bookMapper.deleteReview(id);
    }

    // 추가: 특정 리뷰 조회 (삭제 권한 확인용)
    public Review getReviewById(int reviewId) {
        return bookMapper.selectReviewById(reviewId);
    }
}
