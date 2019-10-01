<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>

<c:if test="${currentUser.role != 'admin' }">
Please log in with an admin account to access this page
</c:if>
<c:if test="${currentUser.role == 'admin' }">
<div class="update-beer-master">
	<c:url var="formAction" value="/updateBeerMaster" />
	<form:form action="${formAction}" method="POST"
		modelAttribute="editBeer">
		<table>
			<tr>
  			<th><label for="beer_id">Select a Beer to edit</label></th>
			<td><form:select path="beer_id" >
					<form:option value="999999">Select the beer you want to edit</form:option>
				  	<c:forEach var="beer" items="${beers}">
						<form:option value="${beer.beer_id}">Beer ID = ${beer.beer_id} | Beer name = ${beer.name} | Brewery ID = ${beer.brewery_id}</form:option>
					</c:forEach>  
				</form:select>   </td>
		</tr>
		<tr>
				<th><label for="beerName">Beer Name</label></th>

				<td><form:input path="name" name="name"
						placeholder="Beer Name" size="35" />
						<form:errors path="name" /><br /></td>
			</tr>

			<tr>
				<th><form:label path="style">Beer Style</form:label></th>
				<td><form:select path="style">
					<form:option value="">Select a Style</form:option>
						<form:option value="Ale">Ale</form:option>
						<form:option value="Belgian-Style Ale">Belgian-Style Ale</form:option>
						<form:option value="Bitter">Bitter</form:option>
						<form:option value="Bock">Bock</form:option>
						<form:option value="Brown Ale">Brown Ale</form:option>
						<form:option value="Cream Ale">Cream Ale</form:option>
						<form:option value="Dark Lager">Dark Lager</form:option>
						<form:option value="Dunkel">Dunkel</form:option>
						<form:option value="IPA">IPA</form:option>
						<form:option value="Irish Red Ale">Irish Red Ale</form:option>						<form:option value="Dunkel">Dunkel</form:option>
						<form:option value="Irish Stout">Irish Stout</form:option>
						<form:option value="Other">Other</form:option>
						<form:option value="Pale Ale">Pale Ale</form:option>
						<form:option value="Pilsner">Pilsner</form:option>
						<form:option value="Porter">Porter</form:option>
						<form:option value="Red Ale">Red Ale</form:option>
						<form:option value="Rye">Rye</form:option>
						<form:option value="Scotch Ale">Scotch Ale</form:option>
						<form:option value="Sour Ale">Sour Ale</form:option>
						<form:option value="Stout">Stout</form:option>
						<form:option value="Wheat">Wheat</form:option>
						<form:option value="Wild Ale">Wild Ale</form:option>				</form:select> 
				<form:errors path="style"/>
				</td>
			</tr>

			<tr>
				<th><form:label path="abv">Beer ABV</form:label></th>
				<td><form:input path="abv" name="abv"
						placeholder="Beer's ABV" size="35" />
						<form:errors path="abv" /><br /></td>
			</tr>
			<tr>
				<th><form:label path="description">Beer Description</form:label></th>
				<td><form:input path="description" name="description"
						placeholder="Describe your beer" size="50" />
						<form:errors path="description" /><br /></td>
			</tr>

		</table>
		<input type="submit" value="Submit" />
	</form:form>
</div>
</c:if>
<%@include file="footer.jsp"%>