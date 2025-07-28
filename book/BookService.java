package service;

import java.util.List;
import model.Book;

public interface BookService {
    Book getBookById(int id);
    List<Book> getAllBooks();
    List<Book> searchBooks(String keyword);
    
}
