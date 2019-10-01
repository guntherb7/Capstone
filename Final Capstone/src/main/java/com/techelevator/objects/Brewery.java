package com.techelevator.objects;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;


public class Brewery {
	
	private int brewery_id;
	
	@NotBlank(message="Please enter a name for your brewery")
	private String name;
	
	@NotBlank(message="Please enter your address")
	private String address;
	
	@NotBlank(message="Please enter your email address")
	@Email(message="Please enter a valid email address")
	private String email;
	
	@NotBlank(message="Please enter a description for your brewery")
	private String description;
	
	private int owners_user_id;
	
	private String gpslocation;
	
	
	
	public String getGpslocation() {
		return gpslocation;
	}
	public void setGpslocation(String gpslocation) {
		this.gpslocation = gpslocation;
	}
	public int getOwners_user_id() {
		return owners_user_id;
	}
	public void setOwners_user_id(int owners_user_id) {
		this.owners_user_id = owners_user_id;
	}
	public int getBrewery_id() {
		return brewery_id;
	}
	public void setBrewery_id(int brewery_id) {
		this.brewery_id = brewery_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

}
