package com.techelevator.controller;


import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.techelevator.model.BeerDAO;
import com.techelevator.model.BreweryDAO;
import com.techelevator.model.ReviewDAO;
import com.techelevator.model.UserDAO;
import com.techelevator.objects.Beer;
import com.techelevator.objects.Brewery;
import com.techelevator.objects.Review;

@Controller


public class BreweryController {

	@Autowired
	private BreweryDAO breweryDAO;
	
	@Autowired
	private BeerDAO beerDAO;
	
	@Autowired
	private ReviewDAO reviewDAO;

	@Autowired
	private UserDAO userDAO;
	
	@RequestMapping(path = "/", method = RequestMethod.GET)
	public String showBrewery(ModelMap map) {
		List<Brewery> breweries = breweryDAO.getAll();

		map.addAttribute("breweries", breweries);

		return "home";

	}

	@RequestMapping(path = "/breweryDetails", method = RequestMethod.GET)
	public String showBreweryDetail(@RequestParam int breweryId, ModelMap map) {
	
		Brewery brewery = breweryDAO.getBreweryById(breweryId);

		map.addAttribute("brewery", brewery);
		
		List<Beer> breweryBeers = beerDAO.getBeersByBreweryId(breweryId);
		map.addAttribute("breweryBeers", breweryBeers);
		
		LinkedHashMap<String, String> breweryUpdates = breweryDAO.getBreweryUpdatesByBreweryId(breweryId);
		map.addAttribute("breweryUpdates", breweryUpdates);
		boolean noNews = true;
		if (breweryUpdates.size() > 0) {
			noNews = false;
		}
		map.addAttribute("noNews", noNews);
		return "breweryDetails";
	}
	
	@RequestMapping(path = "/addBrewery", method = RequestMethod.GET)
	public String showAddBrewery(ModelMap map) {
		if(! map.containsAttribute("addBrewery")) {
		map.addAttribute("addBrewery", new Brewery());
		}
		map.addAttribute("allBrewers", userDAO.getAllBrewers());
		return "addBrewery";

	}
	
	@RequestMapping(path = "/addBrewery", method = RequestMethod.POST)
	public String submitAddedBrewery(@Valid @ModelAttribute("addBrewery") Brewery brewery, BindingResult result,
			RedirectAttributes attr) {
		
			if(result.hasErrors()) {
				return "addBrewery";
			}
			
			breweryDAO.saveBrewery(brewery);
			attr.addFlashAttribute(brewery);
			return "redirect:/";

	}
	
	//beer details shows all the reviews for the beer loaded
	
	@RequestMapping(path = "/beerDetails", method = RequestMethod.GET)
	public String showBeerDetail(@RequestParam int beerId, HttpServletRequest request, ModelMap map) {
		List<Review> reviews = reviewDAO.getReviewByBeerId(beerId);
		Beer beer = beerDAO.getBeerByBeerId(beerId);
		
		int numberOfReviews = reviews.size();
		request.setAttribute("numberOfReviews", numberOfReviews);
		
		int totalRating = 0;
		for (int i = 0; i < reviews.size(); i++) {
			totalRating+= reviews.get(i).getRating();
		}
		
		map.addAttribute("totalRating", totalRating);
		map.addAttribute("beer", beer);
		map.addAttribute("reviews", reviews);
		map.addAttribute("brewery", breweryDAO.getBreweryById(beer.getBrewery_id()));
		if(! map.containsAttribute("submitReview")) {
			map.addAttribute("submitReview", new Review());
			}
		
		
		return "beerDetails";
	}
	
	//following 2 methods allow a beer to be added to a specific brewery
	
	@RequestMapping(path = "/addBeer", method = RequestMethod.GET)
	public String showAddBeer(@RequestParam int breweryId, ModelMap map) {
		List<Brewery> breweries = breweryDAO.getAll();

		map.addAttribute("breweries", breweries);
		
		Brewery brewery = breweryDAO.getBreweryById(breweryId);

		map.addAttribute("brewery", brewery);
		
		map.addAttribute("breweryId", breweryId);
		if(! map.containsAttribute("addBeer")) {
		map.addAttribute("addBeer", new Beer());
		}
		
		return "addBeer";

	}
	
	@RequestMapping(path = "/addBeer", method = RequestMethod.POST)
	public String submitAddedBrewery(@Valid @ModelAttribute("addBeer") Beer beer, BindingResult result,
			RedirectAttributes attr, HttpServletRequest request) {
		
			if(result.hasErrors()) {
				return "addBeer";
			}
			
			beerDAO.saveBeer(beer);
			int breweryId = Integer.parseInt(request.getParameter("brewery_id"));

		return "redirect:/breweryDetails?breweryId=" + breweryId;
		 
	}
	
	
 @RequestMapping(path = "/submitReview", method = RequestMethod.POST)
 public String submitReview(@Valid @ModelAttribute("saveReview") Review review, BindingResult result,
 			RedirectAttributes attr, HttpServletRequest request) {
	 
	 if(result.hasErrors()) {
			return "beerDetails";
		}
 			
	 reviewDAO.saveReview(review);
	 int beerId = Integer.parseInt(request.getParameter("beer_id"));
	 	return "redirect:/beerDetails?beerId=" + beerId;
 }

 //below method allows brewery owners to append responses to customer beer reviews
 
	@RequestMapping(path = "/submitReviewResponse", method = RequestMethod.POST)
	public String submitReviewResponse(HttpServletRequest request) {
		String brewer_response = request.getParameter("brewer_response");
		int review_id = Integer.parseInt(request.getParameter("review_id"));
		int beerId = Integer.parseInt(request.getParameter("beerId"));

		reviewDAO.breweryResponseToReview(review_id, brewer_response);
		return "redirect:/beerDetails?beerId=" + beerId;
	}
 
 //following 2 methods allow any beer to be switched to active or inactive 

	@RequestMapping(path = "/hideBeer", method = RequestMethod.GET)
	public String showHideBeer(@RequestParam int breweryId, ModelMap map) {
		
		List<Beer> allBeers = beerDAO.getBeersByBreweryId(breweryId);
		
		map.addAttribute("allBeers", allBeers);
		
		
		return "hideBeer";

	}
	
	@RequestMapping(path = "/hideBeer", method = RequestMethod.POST)
	public String submitHideBeer(@RequestParam int beer_id, HttpServletRequest request) {
		 
			
		beerDAO.flipBeerActiveProperty(beer_id);
		int userId = Integer.parseInt(request.getParameter("userId"));
		Brewery brewery = breweryDAO.getBreweryByUserId(userId);
		int breweryId = brewery.getBrewery_id();
		return "redirect:/updateBeersByBrewery?breweryId=" + breweryId;
		 
	}
	
	//following 2 methods allow the master editing of any brewery in our DB
	
	@RequestMapping(path = "/updateBrewery", method = RequestMethod.GET)
	public String showUpdateBrewery(ModelMap map) {
		List<Brewery> breweries = breweryDAO.getAll();

		map.addAttribute("breweries", breweries);
		
		if(! map.containsAttribute("editBrewery")) {
		map.addAttribute("editBrewery", new Brewery());
		}
		
		return "updateBrewery";

	}
	
	@RequestMapping(path = "/updateBrewery", method = RequestMethod.POST)
	public String submitUpdatedBrewery(@Valid @ModelAttribute("editBrewery") Brewery brewery, BindingResult result,
			RedirectAttributes attr) {
		
			if(result.hasErrors()) {
				return "updateBrewery";
			}
			
			breweryDAO.updateBrewery(brewery);
			
		return "redirect:/";
		 
	}
	
	//following 2 methods allow editing of a specific brewery via the request parameter brewery id
	
	@RequestMapping(path = "/updateSpecificBrewery", method = RequestMethod.GET)
	public String showUpdateSpecificBrewery(@RequestParam int userId, ModelMap map) {

		Brewery brewery = breweryDAO.getBreweryByUserId(userId);

		map.addAttribute("brewery", brewery);
		
		List<Beer> allBeers = beerDAO.getBeersByBreweryId(brewery.getBrewery_id());
		
		map.addAttribute("allBeers", allBeers);

		if(! map.containsAttribute("editBrewery")) {
		map.addAttribute("editBrewery", new Brewery());
		}
		
		return "updateSpecificBrewery";

	}
	
	@RequestMapping(path = "/updateSpecificBrewery", method = RequestMethod.POST)
	public String submitUpdatedSpecificBrewery(@Valid @ModelAttribute("editBrewery") Brewery brewery, BindingResult result,
			RedirectAttributes attr, HttpServletRequest request) {
		
			if(result.hasErrors()) {
				return "updateSpecificBrewery";
			}
			
			breweryDAO.updateBrewery(brewery);
			int breweryId = Integer.parseInt(request.getParameter("brewery_id"));

		return "redirect:/breweryDetails?breweryId=" + breweryId;
		 
	}
	
	//following 2 methods allow master editing of any beer in our DB
	
	@RequestMapping(path = "/updateBeerMaster", method = RequestMethod.GET)
	public String showUpdateBeerMaster(ModelMap map) {
		
		List<Beer> beers = beerDAO.getAllBeers();
		 
		map.addAttribute("beers", beers);
		
		if(! map.containsAttribute("editBeer")) {
		map.addAttribute("editBeer", new Beer());
		}
		
		return "updateBeerMaster";

	}
	
	@RequestMapping(path = "/updateBeerMaster", method = RequestMethod.POST)
	public String submitUpdatedBeerMaster(@Valid @ModelAttribute("editBeer") Beer beer, BindingResult result,
			RedirectAttributes attr) {
		
			if(result.hasErrors()) {
				return "updateBeerMaster";
			}
			
			beerDAO.updateBeer(beer);
			
		return "redirect:/";
		 
	}
	
	//following 2 methods allow editing of the specific beer sent in the request parameter
	
	@RequestMapping(path = "/updateSpecificBeer", method = RequestMethod.GET)
	public String showUpdateSpecificBeer(@RequestParam int beerId, ModelMap map) {

		Beer beer = beerDAO.getBeerByBeerId(beerId);
		 
		map.addAttribute("beer", beer);
		
		if(! map.containsAttribute("editBeer")) {
		map.addAttribute("editBeer", new Beer());
		}
				
		return "updateSpecificBeer";

	}
	
	@RequestMapping(path = "/updateSpecificBeer", method = RequestMethod.POST)
	public String submitUpdatedSpecificBeer(@Valid @ModelAttribute("editBeer") Beer beer, BindingResult result,
			RedirectAttributes attr, HttpServletRequest request) {
		
			if(result.hasErrors()) {
				return "updateSpecificBeer";
			}
			
			beerDAO.updateBeer(beer);
			int beerId = Integer.parseInt(request.getParameter("beer_id"));
 
			return "redirect:/beerDetails?beerId=" + beerId;
		 
	}
	
	//following 2 methods give a page that allows editing of any beer owned by the parametered brewery
	
	@RequestMapping(path = "/updateBeersByBrewery", method = RequestMethod.GET)
	public String showUpdateBeersByBrewery(@RequestParam int breweryId, ModelMap map) {
		
		List<Beer> beers = beerDAO.getBeersByBreweryId(breweryId);
		Brewery brewery = breweryDAO.getBreweryById(breweryId);

		map.addAttribute("brewery", brewery);
		map.addAttribute("beers", beers);
		map.addAttribute("allBeers", beers);
		if(! map.containsAttribute("editBeer")) {
		map.addAttribute("editBeer", new Beer());
		}
		
		return "updateBeersByBrewery";

	}
	
	@RequestMapping(path = "/updateBeersByBrewery", method = RequestMethod.POST)
	public String submitUpdatedBeersByBrewery(@Valid @ModelAttribute("editBeer") Beer beer, BindingResult result,
			RedirectAttributes attr) {
		
			if(result.hasErrors()) {
				return "updateBeersByBrewery";
			}
			
			beerDAO.updateBeer(beer);
			
		return "redirect:/";
		 
	}
	
	@RequestMapping(path = "/submitBrewNews", method = RequestMethod.POST)
	public String submitBrewNews(HttpServletRequest request) {
		String brewNews = request.getParameter("breweryNews");
		int breweryId = Integer.parseInt(request.getParameter("brewery_id"));
		
		breweryDAO.saveBreweryNews(brewNews, breweryId);

		return "redirect:/breweryDetails?breweryId=" + breweryId;
	}
	
}
