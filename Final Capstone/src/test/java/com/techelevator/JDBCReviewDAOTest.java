package com.techelevator;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import com.techelevator.model.JDBCReviewDAO;
import com.techelevator.objects.Review;

public class JDBCReviewDAOTest extends DAOIntegrationTest {
	
	private JDBCReviewDAO jdbcReviewDAO = new JDBCReviewDAO(getDataSource());
	private JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
	private Review newReview;
	private JDBCReviewDAO dao = new JDBCReviewDAO(getDataSource());
	
	
	@Before
	public void setUp() throws Exception {
		
		String sqlInsertTest = "INSERT INTO reviews " +
				"(beer_id, name, rating, review) " +
				"VALUES " +
				"(1, 'TEST NAME', '3', 'This beer is alright')";
		jdbcTemplate.update(sqlInsertTest);	
		
	}
	
	
	@Test
	public void getReviewByReviewIdTest() {
		
		List<Review> review = jdbcReviewDAO.getReviewByReviewId(1);
		Review testReview = review.get(0);
		System.out.print(review.get(0).getReview_id());
		
		assertEquals("TEST NAME", testReview.getName());
		assertEquals("3", testReview.getRating());
		assertEquals("This beer is alright", testReview.getReview());	
		
	}
	
	
	@Test
	public void getReviewByBeerIdTest() {
		
		List<Review> review = jdbcReviewDAO.getReviewByBeerId(1);
		Review testReview2 = review.get(1);
		System.out.print(review.get(0).getBeer_id());
		
	}
	
	@Test
	public void saveReviewTest() {
		Review review = new Review();
		
		review.setBeer_id(1);
		review.setName("TEST NAME");
		review.setRating(4);
		review.setReview("This beer is alright");
		
		jdbcReviewDAO.saveReview(review);
//		
//		List<Review> testReviewList = jdbcReviewDAO.saveReview();
//		Review testReview2 = review.testReviewList.size()-1);
		
		
	}

}
