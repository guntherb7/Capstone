package com.techelevator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import com.techelevator.model.JDBCBeerDAO;
import com.techelevator.objects.Beer;
 

public class JDBCBeerDAOTest extends DAOIntegrationTest {

	private JDBCBeerDAO jdbcBeerDAO = new JDBCBeerDAO(getDataSource());
	private JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());

	@Before
	public void setUp() throws Exception {
		
		String sqlInsertTest = "INSERT INTO beer " + 
				"(brewery_id, name, style, abv, description) " + 
				"VALUES " + 
				"(2, 'TEST LIGHT', 'Light', '4.0', 'Get tested up')";
		jdbcTemplate.update(sqlInsertTest);
	}
	
	@Test
	public void getBeerByBreweryIdTest() {
		 
		List<Beer> beers = jdbcBeerDAO.getBeersByBreweryId(2);
		
		Beer testBeer = beers.get(beers.size()-1);
		System.out.print(testBeer.getName());
		
		assertEquals("TEST LIGHT", testBeer.getName());
		assertEquals("4.0", testBeer.getAbv());
		assertEquals("Light", testBeer.getStyle());
		assertEquals("Get tested up", testBeer.getDescription());
		assertEquals(2, testBeer.getBrewery_id());
		
	}
	
	
	@Test
	public void getBeerByBeerIdTest()  {
		
		Beer beer = jdbcBeerDAO.getBeerByBeerId(1);
		Beer testBeer2 = beer;
		System.out.print(beer.getBeer_id());
	
	
	assertEquals(1, testBeer2.getBrewery_id());
	assertEquals(1, testBeer2.getBeer_id());
 
	
	}
	
	@Test
	public void saveBeerTest()  {
		Beer beer = new Beer();
	
		beer.setAbv("5");
		beer.setBrewery_id(1);
		beer.setDescription("test beer description");
		beer.setName("test beer");
		beer.setStyle("Lager");
		
		jdbcBeerDAO.saveBeer(beer);
		
		
		List<Beer> beers = jdbcBeerDAO.getBeersByBreweryId(1);
		Beer testBeer = beers.get(beers.size()-1);
		
		assertEquals(beer.getName(), testBeer.getName());
		assertEquals(beer.getAbv(), testBeer.getAbv());
		assertEquals(beer.getStyle(), testBeer.getStyle());
		assertEquals(beer.getDescription(), testBeer.getDescription());
		assertEquals(beer.getBrewery_id(), testBeer.getBrewery_id());
		
	}
	
	//requirements for delete beer turned out to be more like make 
	//beer inactive, not delete from DB; code here just for reference
	
//	@Test
//	public void deleteBeerTest()  {
//		Beer beer = new Beer();
//		
//		beer.setAbv("5");
//		beer.setBrewery_id(1);
//		beer.setDescription("test beer description");
//		beer.setName("test beer");
//		beer.setStyle("Lager");
//		
//		jdbcBeerDAO.saveBeer(beer);
//		
//		List<Beer> beers = jdbcBeerDAO.getBeersByBreweryId(1);
//		jdbcBeerDAO.deleteBeer(beers.get(beers.size()-1).getBeer_id());
//		beers = jdbcBeerDAO.getBeersByBreweryId(1);
//		Beer testBeer = beers.get(beers.size()-1);
//
//		assertNotEquals(beer.getName(), testBeer.getName());
//		assertNotEquals(beer.getAbv(), testBeer.getAbv());
//		assertNotEquals(beer.getStyle(), testBeer.getStyle());
//		assertNotEquals(beer.getDescription(), testBeer.getDescription());
//	
//	}	
	
	@Test
	public void filpBeerActivePropertyTest()  {
	
		List<Beer> beers = jdbcBeerDAO.getBeersByBreweryId(1);
		Beer beer = beers.get(0);
		
		assertEquals(true, beer.isActive());

		jdbcBeerDAO.flipBeerActiveProperty(beer.getBeer_id());

		
		beers = jdbcBeerDAO.getBeersByBreweryId(1);
		beer = beers.get(0);
		
		assertEquals(false, beer.isActive());

	}
	
	@Test
	public void getAllBeersTest()  {
		List<Beer> beers = jdbcBeerDAO.getAllBeers();
		
		System.out.println(beers.get(beers.size()-1).getName());
		assertEquals("4.0", beers.get(beers.size()-1).getAbv());
		assertEquals("TEST LIGHT", beers.get(beers.size()-1).getName());
		assertEquals("Get tested up", beers.get(beers.size()-1).getDescription());
		assertEquals("Light", beers.get(beers.size()-1).getStyle());
	}
	
	@Test
	public void updateBeerTest()  {
		Beer beer = new Beer();
		
		beer.setAbv("5");
		beer.setBrewery_id(1);
		beer.setDescription("test beer description");
		beer.setName("test beer");
		beer.setStyle("Lager");
		beer.setBeer_id(1);
		jdbcBeerDAO.updateBeer(beer);
			
		List<Beer> beers = jdbcBeerDAO.getBeersByBreweryId(1);
		Beer testBeer = beers.get(0);
		
		assertEquals(beer.getName(), testBeer.getName());
		assertEquals(beer.getAbv(), testBeer.getAbv());
		assertEquals(beer.getStyle(), testBeer.getStyle());
		assertEquals(beer.getDescription(), testBeer.getDescription());
		assertEquals(beer.getBrewery_id(), testBeer.getBrewery_id());
	
	}
	
}
