package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.objects.Review;

@Component
public class JDBCReviewDAO implements ReviewDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCReviewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public List<Review> getReviewByReviewId(int reviewId) {

		List<Review> getReviewByReviewId = new ArrayList<Review>();
		String sqlSelectReviewByReviewId = "SELECT beer_id, review_id, name, rating, review, brewer_response " + "FROM reviews "
				+ "WHERE review_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectReviewByReviewId, reviewId);
		if (results.next()) {
			getReviewByReviewId.add(mapRowtoReview(results));
		}
		return getReviewByReviewId;
	}

	private Review mapRowtoReview(SqlRowSet row) {
		Review review = new Review();
		review.setBeer_id(row.getInt("beer_id"));
		review.setReview_id(row.getInt("review_id"));
		review.setName(row.getString("name"));
		review.setRating(row.getInt("rating"));
		review.setReview(row.getString("review"));
		review.setBrewer_response(row.getString("brewer_response"));
		return review;
	}

	@Override
	public List<Review> getReviewByBeerId(int beer_Id) {

		List<Review> getReviewByBeerId = new ArrayList<Review>();
		String sqlSelectReviewByBeerId = "SELECT beer_id, review_id, name, rating, review, brewer_response " + "FROM reviews "
				+ "WHERE beer_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectReviewByBeerId, beer_Id);
		while (results.next()) {
			getReviewByBeerId.add(mapRowtoReview(results));
		}
		return getReviewByBeerId;

	}

	@Override
	public void saveReview(Review review) {
		String sqlSaveReview = "INSERT INTO reviews " + "(beer_id, name, rating, review) " + "VALUES " + "(?, ?, ?, ?)";
		jdbcTemplate.update(sqlSaveReview, review.getBeer_id(), review.getName(), review.getRating(),
				review.getReview());

	}
	
	@Override
	public void breweryResponseToReview(int reviewId, String brewer_response){
		String sqlEditResponseToReview = "UPDATE reviews " + 
	"SET brewer_response = ? " + 
	"WHERE review_id = ?;";
	jdbcTemplate.update(sqlEditResponseToReview, brewer_response, reviewId);
	
	}


}
