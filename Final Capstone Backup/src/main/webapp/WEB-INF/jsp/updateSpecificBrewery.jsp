<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>
<c:if test="${currentUser.role == 'brewer' }">
	<c:url var="editMyBeers"
		value="/updateBeersByBrewery?breweryId=${brewery.brewery_id}" />
	<br>
	<a href="${editMyBeers}">Update my beers</a>
	<c:url var="hideMyBeers"
		value="/hideBeer?breweryId=${brewery.brewery_id}" />
	<br>
<%-- 	<a href="${hideMyBeers}">Change my active beers</a>
	<c:url var="addABeer" value="/addBeer?breweryId=${brewery.brewery_id}" />
	<br> --%>
	<a href="${addABeer}">Add a beer</a>
	<c:url var="viewMyBrewery"
		value="/breweryDetails?breweryId=${brewery.brewery_id}" />
	<br>
	<a href="${viewMyBrewery}">View my brewery page</a>
	<div class="update-specific-brewery">
		<c:url var="formAction" value="/updateSpecificBrewery" />
		<form:form action="${formAction}" method="POST"
			modelAttribute="editBrewery">
			<table>

				<tr>
					<th><label for="breweryName">Brewery Name</label></th>

					<td><form:input path="name" name="name"
							placeholder="Brewery's Name" size="35" value="${brewery.name}" />
						<form:errors path="name" /><br /></td>
				</tr>

				<tr>
					<th><form:label path="email">Brewery Email</form:label></th>
					<td><form:input path="email" name="email"
							value="${brewery.email}" placeholder="Enter Your Email" size="35" />
						<form:errors path="email" /> <br /></td>
				</tr>

				<tr>
					<th><form:label path="address">Brewery Address</form:label></th>
					<td><form:input path="address" name="address"
							value="${brewery.address}" placeholder="Enter Your Address"
							size="35" /> <form:errors path="address" /><br /></td>
				</tr>
				<tr>
					<th><label for="gpslocation">GPS Coordinates</label></th>
					<td><form:input path="gpslocation" name="gpslocation"
							placeholder="Brewery's GPS Coordinates" size="35" value="${brewery.gpslocation}" />
						<br /></td>
				</tr>				
				<tr>
					<th><form:label path="description">Brewery Description</form:label></th>
					<td><form:input path="description" name="description"
							value="${brewery.description}" placeholder="Enter A Description"
							size="50" /> <form:errors path="description" /><br /></td>
				</tr>

			</table>
			<input type="hidden" name="brewery_id" value="${brewery.brewery_id}">
			<input type="submit" value="Submit Brewery Changes" />
		</form:form>
	</div>
	<br>
	<br>
	
	<c:url value="/submitBrewNews" var="submitBrewNewsUrl" />
	<form action="${submitBrewNewsUrl}" method="POST">
		Post a news update to your brewery page: &ensp;
		<input type="hidden" name="brewery_id" value="${brewery.brewery_id}">
	 	<input type="text" name="breweryNews" size="50" placeholder="Enter your news update here"> 
			<input type="submit" value="Submit News Post">

	</form>
	
</c:if>
<c:if test="${currentUser.role != 'brewer' }">
Please log in with a brewer account to access this page
</c:if>


<%@include file="footer.jsp"%>