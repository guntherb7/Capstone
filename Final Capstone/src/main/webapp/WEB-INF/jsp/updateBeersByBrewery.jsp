<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>
<c:if test="${currentUser.role == 'brewer' }">
	<br>
	<br>
	<c:forEach var="beer" items="${allBeers}">

		<c:url var="formAction" value="/hideBeer" />
		<form action="${formAction}" method="POST">
			<input type="hidden" name="brewery_id" value="${brewery.brewery_id}">
			<input type="hidden" name="userId" value="${currentUser.id}">
			<input name="beer_id" type="hidden" value="${beer.beer_id}">
			<c:if test="${beer.active ==true }">
				<input type="submit" value="Make ${beer.name} inactive" />
			</c:if>
			<c:if test="${beer.active ==false }">
				<input type="submit" value="Make ${beer.name} active" />
			</c:if>
			<c:url var="editThisBeer"
				value="/updateSpecificBeer?beerId=${beer.beer_id}" />
			<br> <a href="${editThisBeer}">Click this link to edit
				${beer.name}</a>
		</form>
	</c:forEach>
	<div class="update-beers-by-brewery">
		<c:url var="formAction" value="/updateBeersByBrewery" />
		<form:form action="${formAction}" method="POST"
			modelAttribute="editBeer">
			<table>
				<tr>
					<th><label for="beer_id">Select a Beer to edit</label></th>
					<td><form:select path="beer_id">
							<form:option value="999999">Select the beer you want to edit</form:option>
							<c:forEach var="beer" items="${beers}">
								<form:option value="${beer.beer_id}">${beer.beer_id} - ${beer.name}</form:option>
							</c:forEach>
						</form:select></td>
				</tr>
				<tr>
					<th><label for="beerName">Beer Name</label></th>

					<td><form:input path="name" name="name"
							placeholder="Beer Name" size="35" /> <form:errors path="name" /></td>
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
						<form:option value="Wild Ale">Wild Ale</form:option>						</form:select> <form:errors path="style" /></td>
				</tr>

				<tr>
					<th><form:label path="abv">Beer ABV</form:label></th>
					<td><form:input path="abv" name="abv" placeholder="Beer's ABV"
							size="35" /> <form:errors path="abv" /></td>
				</tr>
				<tr>
					<th><form:label path="description">Beer Description</form:label></th>
					<td><form:input path="description" name="description"
							placeholder="Describe your beer" size="50" /> <form:errors
							path="description" /></td>
				</tr>

			</table>
			<input type="submit" value="Submit" />
		</form:form>
	</div>
</c:if>
<c:if test="${currentUser.role != 'brewer' }">
Please log in with your brewer account to update your brewery's beers
</c:if>
<%@include file="footer.jsp"%>