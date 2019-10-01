package com.techelevator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.JDBCBreweryDAO;
import com.techelevator.objects.Brewery;

public class JDBCBreweryDAOTest extends DAOIntegrationTest {
	
private JDBCBreweryDAO jdbcBreweryDAO = new JDBCBreweryDAO(getDataSource());
private JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
private Brewery brewery1;
private JDBCBreweryDAO dao = new JDBCBreweryDAO(getDataSource());

@Before
public void setUp() throws Exception {
	
	String sqlInsertTest = "INSERT INTO brewery " + 
			"(name, address, email, description) " + 
			"VALUES " + 
			"('TEST', 'TestBrewery address', 'test@email.com', 'this is the testiest brewery there be')";
	jdbcTemplate.update(sqlInsertTest);
}

@Test
public void getAllBreweriesTest() {
	
	String sql = "SELECT COUNT(*) as brewery_count FROM BREWERY";
	SqlRowSet select = jdbcTemplate.queryForRowSet(sql);
	select.next();
	long expected = select.getLong("brewery_count");
	long result = (long)jdbcBreweryDAO.getAll().size();
	Assert.assertEquals(expected, result);
	
}


@Test
public void saveBreweryTest() {
	List<Brewery> allBreweries = jdbcBreweryDAO.getAll();
	
	int numberOfBreweries = allBreweries.size();
	
	Brewery brewery = new Brewery();
	brewery.setName("TEST");
	brewery.setDescription("this is the testiest brewery there be");
	brewery.setAddress("TestBrewery address");
	brewery.setEmail("test@email.com");
	
	
	jdbcBreweryDAO.saveBrewery(brewery);
	
	List<Brewery> allBreweriesPlusOne = jdbcBreweryDAO.getAll();
	
	int numberOfBreweriesPlusOne = allBreweriesPlusOne.size();
 
	
	assertNotEquals(numberOfBreweries, numberOfBreweriesPlusOne);
}


//can't get it to work lol bad sql grammar
@Test
public void getBreweryByIdTest() {
	List<Brewery> allBreweries = jdbcBreweryDAO.getAll();
	
	int numberOfBreweries = allBreweries.size();
	 
	Brewery brewery = jdbcBreweryDAO.getBreweryById(1);
	
	 //System.out.println(brewery.getDescription());

	assertEquals("BREWERY ONE", brewery.getName());
	assertEquals("111 FAKE STREET COLUMBUS OHIO 44134", brewery.getAddress());
	assertEquals("THIS BREWERY RULES",brewery.getDescription());
	assertEquals("BREWERYONE@GMAIL.COM",brewery.getEmail());
	
}

@Test 
public void displayAllBreweries() {
	
	List<Brewery> testList = jdbcBreweryDAO.getAll();
	
	brewery1 = new Brewery();
	brewery1.setName("BreweryName");
	brewery1.setAddress("111 Brewery Dr, Ann Arbor, Michigan");
	brewery1.setEmail("beerGuy@brewery.com");
	brewery1.setDescription("A nice place to crack open a cold one");
	String sql = "INSERT INTO BREWERY (name, address, email, description) Values (?,?,?,?)";
	jdbcTemplate.update(sql, 
			brewery1.getName(),
			brewery1.getAddress(), 
			brewery1.getEmail(), 
			brewery1.getDescription());
	List<Brewery> testList2 = dao.getAll();
	Assert.assertEquals(testList.size()+1, testList2.size());
	
	
	
}


//@Test 
//public void getNextBreweryIdTest() {
//	System.out.println(dao.nextBreweryId());
//	Assert.assertEquals(3, dao.nextBreweryId());
//	
//}

@Test 
public void updateBreweryTest() {
	
	brewery1 = new Brewery();
	brewery1.setName("BreweryName");
	brewery1.setAddress("111 Brewery Dr, Ann Arbor, Michigan");
	brewery1.setEmail("beerGuy@brewery.com");
	brewery1.setDescription("A nice place to crack open a cold one");
	brewery1.setBrewery_id(1);
	
	jdbcBreweryDAO.updateBrewery(brewery1);

	Brewery brewery = jdbcBreweryDAO.getBreweryById(1);
	
	 System.out.println(brewery.getDescription() + "test");

	
	assertEquals("BreweryName", brewery.getName());
	assertEquals("111 Brewery Dr, Ann Arbor, Michigan", brewery.getAddress());
	assertEquals("A nice place to crack open a cold one",brewery.getDescription());
	assertEquals("beerGuy@brewery.com",brewery.getEmail());
	
}


@Test 
public void getBreweryByUserIdTest() {
	Brewery brewery = jdbcBreweryDAO.getBreweryByUserId(1);

	assertEquals("BREWERY ONE", brewery.getName());
	
}

}
