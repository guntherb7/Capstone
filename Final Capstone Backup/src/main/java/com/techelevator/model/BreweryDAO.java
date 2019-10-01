package com.techelevator.model;
import java.util.LinkedHashMap;
import java.util.List;

import com.techelevator.objects.Brewery;
public interface BreweryDAO {

	//getAll method retrieves all items from Brewery Class
	
	public List<Brewery> getAll();
	
	//saves a new brewery object to our db
	public void saveBrewery(Brewery brewery);
	
	//returns a brewery object associated with the id queried
	public Brewery getBreweryById(int id);
	
	//updates our db with the new brewery's parameters
	public void updateBrewery(Brewery brewery);
	
	//get the brewery object associated with the current account id
	public Brewery getBreweryByUserId(int userId);
	
	//returns a map of news updates/stories published by a brewery
	public LinkedHashMap<String, String> getBreweryUpdatesByBreweryId(int breweryId);

	//save a new news story to a brewery's database
	public void saveBreweryNews(String breweryNews, int breweryId);
}
