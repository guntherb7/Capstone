package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.objects.Beer;
import com.techelevator.objects.Brewery;

@Component
public class JDBCBeerDAO implements BeerDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCBeerDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public List<Beer> getBeersByBreweryId(int breweryId) {

		List<Beer> beersByBreweryId = new ArrayList<Beer>();
		String sqlSelectBeerByBreweryId = "SELECT brewery_id, beer_id, name, style, abv, description, active "
		+ "FROM BEER "+ 
		"WHERE brewery_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectBeerByBreweryId, breweryId);
		while (results.next()) {
			beersByBreweryId.add(mapRowToBeer(results));
		}

		return beersByBreweryId;
	}

	private Beer mapRowToBeer(SqlRowSet row) {
		Beer beer = new Beer();
		beer.setBrewery_id(row.getInt("brewery_id"));
		beer.setBeer_id(row.getInt("beer_id"));
		beer.setDescription(row.getString("description"));
		beer.setStyle(row.getString("style"));
		beer.setName(row.getString("name"));
		beer.setAbv(row.getString("abv"));
		beer.setActive(row.getBoolean("active"));

		return beer;
	}

	@Override
	public Beer getBeerByBeerId(int id) {
		Beer beer = new Beer();
		String sqlSelectBeerById = "SELECT brewery_id, beer_id, name, style, abv, description, active " + "FROM BEER "
				+ "WHERE beer_id = ?;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectBeerById, id);
		if (results.next()) {
			beer = mapRowToBeer(results);
		}
		return beer;
	}

	@Override
	public void saveBeer(Beer beer) {
		String sqlInsertBeer = "INSERT INTO BEER " + "(brewery_id, name, style, abv, description) " + "VALUES "
				+ "(?, ?, ?, ?, ?)";
		jdbcTemplate.update(sqlInsertBeer, beer.getBrewery_id(), beer.getName(), beer.getStyle(), beer.getAbv(),
				beer.getDescription());

	}

	//requirements for delete beer turned out to be more like make 
	//beer inactive, not delete from DB; code here just for reference
	
//	@Override
//	public void deleteBeer(int deleteBeerId) {
//		String sqlDeleteBeer = "DELETE FROM beer " + "WHERE beer_id = ?";
//
//		jdbcTemplate.update(sqlDeleteBeer, deleteBeerId);
//
//	}
 

	@Override
	public void flipBeerActiveProperty(int updateBeerId) {
		String sqlChangeBeerActiveProperty = "UPDATE BEER SET ACTIVE = NOT ACTIVE " + 
				"WHERE beer_id = ?";

		jdbcTemplate.update(sqlChangeBeerActiveProperty, updateBeerId);
 
	}

	@Override
	public List<Beer> getAllBeers() {
		
		List<Beer> allBeers = new ArrayList<Beer>();
		String sqlGetAllBeers = "SELECT brewery_id, beer_id, name, style, abv, description, active "
		+ "FROM BEER";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllBeers);
		while (results.next()) {
			allBeers.add(mapRowToBeer(results));
		}

		return allBeers;

	}

	@Override
	public void updateBeer(Beer beer) {
		String sqlEditBeerInfo = "UPDATE BEER " + 
				"SET name = ?, style = ?, abv = ?, description = ? " + 
				"WHERE beer_id = ?;";
				

		jdbcTemplate.update(sqlEditBeerInfo, beer.getName(), beer.getStyle(), beer.getAbv(), beer.getDescription(), beer.getBeer_id());
 
		
	}

	
	
}
