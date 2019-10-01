package com.techelevator.model;

import java.util.List;

import com.techelevator.objects.Beer;
import com.techelevator.objects.Brewery;

public interface BeerDAO {

	// returns a list of beer objects associated with the brewery ID passed into the
	// method
	public List<Beer> getBeersByBreweryId(int breweryId);

	// returns a list of all of the beer objects in our db
	public List<Beer> getAllBeers();

	// returns a beer object associated with the inputted beer ID
	public Beer getBeerByBeerId(int beerId);

	// saves a new beer object to our DB
	public void saveBeer(Beer beer);


	// changes the active property of a beer in our DB to the opposite of what it is
	public void flipBeerActiveProperty(int deleteBeerId);

	public void updateBeer(Beer beer);
	
	// deletes a beer object from our DB by the ID inputted
	//note: method not necessary for project; starter code left in case the functionality comes into play at a later time
	//	public void deleteBeer(int deleteBeerId);

}
