package com.techelevator.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.TreeMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.objects.Brewery;

@Component
public class JDBCBreweryDAO implements BreweryDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCBreweryDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	//get all breweries as objects in a list
	@Override
	public List<Brewery> getAll() {
		List<Brewery> breweries = new ArrayList<>();
		String sqlSelectBreweries = "SELECT brewery_id, name, address, email, description, owners_user_id, gpslocation FROM BREWERY";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectBreweries);
		while (results.next()) {
			breweries.add(mapRowToBrewery(results));
		}
		return breweries;
	}

	
	//insert a new brewery object into our database
	@Override
	public void saveBrewery(Brewery brewery) {
		String sqlInsertBrewery = "INSERT INTO BREWERY " + "(name, address, email, description, owners_user_id, gpslocation) "
				+ "VALUES " + "(?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sqlInsertBrewery, brewery.getName(), brewery.getAddress(), brewery.getEmail(),
				brewery.getDescription(), brewery.getOwners_user_id(), brewery.getGpslocation());

	}

	//gets a brewery object associated with the ID given to the method
	@Override
	public Brewery getBreweryById(int id) {
		Brewery brewery = new Brewery();
		String sqlSelectBreweryById = "SELECT brewery_id, name, address, email, description, owners_user_id, gpslocation "
				+ "FROM BREWERY " + "WHERE brewery_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectBreweryById, id);
		if (results.next()) {
			brewery = mapRowToBrewery(results);
		}
		return brewery;
	}

	// MAP ROW BREWERY HERE

	private Brewery mapRowToBrewery(SqlRowSet row) {
		Brewery brewery = new Brewery();
		brewery.setBrewery_id(row.getInt("brewery_id"));
		brewery.setAddress(row.getString("address"));
		brewery.setDescription(row.getString("description"));
		brewery.setEmail(row.getString("email"));
		brewery.setName(row.getString("name"));
		brewery.setOwners_user_id(row.getInt("owners_user_id"));
		brewery.setGpslocation(row.getString("gpslocation"));
		
		return brewery;
	}

	// get the next available brewery ID so we can provide the user a link to
	// their new brewery page after they create it
	// needs work
	// @Override
	// public int nextBreweryId() {
	// Brewery brewery = new Brewery();
	// String findNextBreweryId = "SELECT COUNT(*) + 1 as brewery_id FROM BREWERY";
	//
	// SqlRowSet nextIdQueryResult = jdbcTemplate.queryForRowSet(findNextBreweryId);
	//
	//// if (nextIdQueryResult.next()) {
	//// brewery = mapRowToBrewery(nextIdQueryResult);
	//// }
	//
	// int nextId = nextIdQueryResult.getInt("brewery_id");
	// System.out.print(String.valueOf(nextId));
	// return nextId;
	// }

	//method to edit a brewery already in the database
	@Override
	public void updateBrewery(Brewery brewery) {
		String sqlEditBreweryInfo = "UPDATE BREWERY " + "SET name = ?, address = ?, email = ?, description = ?, gpslocation = ? "
				+ "WHERE brewery_id = ?;";

		jdbcTemplate.update(sqlEditBreweryInfo, brewery.getName(), brewery.getAddress(), brewery.getEmail(),
				brewery.getDescription(), brewery.getGpslocation(), brewery.getBrewery_id());

	}

	//get a brewery owned by a certain userID
	@Override
	public Brewery getBreweryByUserId(int ownersUserId) {

		Brewery brewery = new Brewery();
		String sqlSelectBreweryByUserId = "SELECT * FROM brewery WHERE owners_user_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectBreweryByUserId, ownersUserId);

		if (results.next()) {
			brewery = mapRowToBrewery(results);
		}
		return brewery;

	}

	@Override
	public LinkedHashMap<String, String> getBreweryUpdatesByBreweryId(int breweryId) {
		LinkedHashMap<String, String> breweryUpdates = new LinkedHashMap<String, String>();
		
		String sqlBreweryUpdatesByBreweryId = "SELECT newsupdate, updatetime FROM brewnews WHERE brewery_id = ? ORDER BY newsitem_ID DESC";
		
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlBreweryUpdatesByBreweryId, breweryId);

		while (results.next()) {
			breweryUpdates.put(results.getString("newsupdate"), results.getString("updatetime"));			
		}
		
		return breweryUpdates;
	}
	
	@Override
	public void saveBreweryNews(String breweryNews, int breweryId) {

		SimpleDateFormat sdf = new SimpleDateFormat("MMMMM d, yyyy");		
		Calendar c = Calendar.getInstance();
		String currentDate = sdf.format(c.getTime());
		
		String sqlInsertBreweryNews = "INSERT INTO brewnews " + "(newsupdate, brewery_id, updatetime) "
				+ "VALUES " + "(?, ?, ?)";
		jdbcTemplate.update(sqlInsertBreweryNews, breweryNews, breweryId, currentDate);

	}
	
}
