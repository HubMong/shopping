package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.ReviewMapper;
import model.review;

@Service
public class ReviewService {

	@Autowired
	ReviewMapper mapper;

	public int save(review review) {
		return mapper.save(review);
	}

	public List<review> getReviewsByBook(int id) {
		return mapper.selectByBookId(id);
	}

	public int deleteById(int id) {
		return mapper.deleteById(id);
	}

	public review getReviewById(int id) {
		return mapper.selectById(id);
	}

	public int update(review review) {
		review previous = mapper.selectById(review.getId());
		if(review.getBookId() == null) review.setBookId(previous.getBookId());
		if(review.getContent() == null) review.setContent(previous.getContent());
		if(review.getId() == null) review.setId(previous.getId());
		if(review.getMemberId() == null) review.setMemberId(previous.getMemberId());
		if(review.getScore() == null) review.setScore(previous.getScore());
		if(review.getWroteOn() == null) review.setWroteOn(previous.getWroteOn());
		
		return mapper.update(review);		
	}
	
	public int getCountByBookId(int bookId) {
		return mapper.countByBookId(bookId);
	}
	
	public int getSumByBookId(int bookId) {
		return mapper.sumScoreByBookId(bookId);
	}
}
