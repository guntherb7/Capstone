package com.techelevator.objects;

import org.hibernate.validator.constraints.NotBlank;

public class Beer {

	private int brewery_id;
	private int beer_id;

	@NotBlank(message = "Please enter the beer's name")
	private String name;

	@NotBlank(message = "Please pick a style")
	private String style;

	@NotBlank(message = "Please enter a description")
	private String description;

	@NotBlank(message = "Please enter the beer's ABV")
	private String abv;

	private boolean active;

	public int getBrewery_id() {
		return brewery_id;
	}

	public void setBrewery_id(int brewery_id) {
		this.brewery_id = brewery_id;
	}

	public int getBeer_id() {
		return beer_id;
	}

	public void setBeer_id(int beer_id) {
		this.beer_id = beer_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAbv() {
		return abv;
	}

	public void setAbv(String abv) {
		this.abv = abv;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

}
