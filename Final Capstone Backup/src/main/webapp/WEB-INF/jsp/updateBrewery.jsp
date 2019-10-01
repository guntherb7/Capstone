<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>
<c:if test="${currentUser.role != 'admin' }">
Please log in with an admin account to access this page
</c:if>
<c:if test="${currentUser.role == 'admin' }">

<div class="update-brewery">
	<c:url var="formAction" value="/updateBrewery" />
	<form:form action="${formAction}" method="POST"
		modelAttribute="editBrewery">
		<table>

			<tr>
				<th><label for="brewery_id">Brewery ID</label></th>
				<td><form:select path="brewery_id">
						<form:option value="999999">Select the brewery you want to edit</form:option>
						<c:forEach var="brewery" items="${breweries}">
							<form:option value="${brewery.brewery_id}">${brewery.brewery_id} - ${brewery.name}</form:option>
						</c:forEach>
					</form:select></td>
			</tr>
			<tr>
				<th><label for="breweryName">Brewery Name</label></th>

				<td><form:input path="name" name="name"
						placeholder="Brewery's Name" size="35" /> <form:errors
						path="name" /><br />
				<br></td>
			</tr>

			<tr>
				<th><form:label path="email">Brewery Email</form:label></th>
				<td><form:input path="email" name="email"
						placeholder="Enter Your Email" size="35" /> <form:errors
						path="email" /> <br />
				<br></td>
			</tr>

			<tr>
				<th><form:label path="address">Brewery Address</form:label></th>
				<td><form:input path="address" name="address"
						placeholder="Enter Your Address" size="35" /> <form:errors
						path="address" /><br />
				<br></td>
			</tr>
			<tr>
				<th><form:label path="description">Brewery Description</form:label></th>
				<td><form:input path="description" name="description"
						placeholder="Enter A Description" size="50" /> <form:errors
						path="description" /><br />
				<br></td>
			</tr>
			<br>
		</table>
		<input type="submit" value="Submit" />
	</form:form>
	<br>
</div>
</c:if>
<%@include file="footer.jsp"%>