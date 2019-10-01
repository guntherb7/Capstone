package com.techelevator.objects;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class Review {

	private int beer_id;
	private int review_id;

	@NotNull(message = "Please enter a rating")
	private Integer rating;

	@NotBlank(message = "Please add a name for your review")
	private String name;

	@NotBlank(message = "Please enter your review")
	private String review;

	private String brewer_response;
	
	public String getBrewer_response() {
		return brewer_response;
	}

	public void setBrewer_response(String brewer_response) {
		this.brewer_response = brewer_response;
	}

	// Gets the Beer ID for the review
	public int getBeer_id() {
		return beer_id;
	}

	public void setBeer_id(int beer_id) {
		this.beer_id = beer_id;
	}

	// Gets the review ID for a particular review
	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	// Gets the name of the reviewer
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// Gets the rating given to the beer by the reviewer
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public void saveReview(Review review) {

	}

}
