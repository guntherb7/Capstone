<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>

<c:if test="${currentUser.role == 'brewer' }">
<div class="update-specific-beer">
	<c:url var="formAction" value="/updateSpecificBeer" />
	<form:form action="${formAction}" method="POST"
		modelAttribute="editBeer">
		<table>

			<tr>
				<th><label for="breweryName">Beer Name</label></th>

				<td><form:input path="name" name="name" placeholder="Beer Name"
						size="35" value="${beer.name}" /> <form:errors path="name" /><br /></td>
			</tr>

			<tr>
				<th><form:label path="style">Beer Style</form:label></th>
				<td><form:select path="style">
						<form:option value="${beer.style}">${beer.style}</form:option>
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
						<form:option value="Wild Ale">Wild Ale</form:option>
					</form:select> <form:errors path="style" /></td>
			</tr>

			<tr>
				<th><form:label path="abv">Beer ABV</form:label></th>
				<td><form:input path="abv" name="abv" value="${beer.abv}"
						placeholder="Beer's ABV" size="35" />
						<form:errors path="abv" /><br /></td>
			</tr>
			
			<tr>
				<th><form:label path="description">Beer Description</form:label></th>
				<td><form:input path="description" name="description"
						value="${beer.description}" placeholder="Enter A Description"
						size="50" /> <form:errors path="description" /><br /></td>
			</tr>

		</table>
		<input type="hidden" name="brewery_id" value="${beer.brewery_id}">
		<input type="hidden" name="beer_id" value="${beer.beer_id}">
		<input type="submit" value="Submit" />
	</form:form>
</div>
</c:if>
<c:if test="${currentUser.role != 'brewer' }">
Please log in with your brewer account to update your brewery's beers
</c:if>
<%@include file="footer.jsp"%>