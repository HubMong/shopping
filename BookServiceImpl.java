package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.BookMapper;
import model.Book;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Override
    public Book getBookById(int id) {
        return bookMapper.selectBookById(id);
    }
}
