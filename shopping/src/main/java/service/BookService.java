package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.BookMapper;
import model.Book;

@Service
public class BookService {

    @Autowired
    private BookMapper bookMapper;

    public Book getBookById(int id) {
        return bookMapper.selectBookById(id);
    }
    
    public List<Book> getAllBooks() {
        return bookMapper.selectAllBooks();
    }
    
    public List<Book> searchBooks(String keyword) {
        return bookMapper.searchBooks(keyword);
    }
}
