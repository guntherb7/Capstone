package com.techelevator.model;

import java.util.List;

import com.techelevator.objects.Review;

public interface ReviewDAO {

	// Returns list of Reviews associated with individual Beers

	public List<Review> getReviewByReviewId(int reviewId);

	public List<Review> getReviewByBeerId(int beer_id);

	public void saveReview(Review review);

	public void breweryResponseToReview(int reviewId, String brewerResponse);
}
