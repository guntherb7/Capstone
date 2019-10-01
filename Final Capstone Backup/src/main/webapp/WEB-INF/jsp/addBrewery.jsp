<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>

<c:if test="${currentUser.role == 'admin' }">

<div class="add-brewery">
	<c:url var="formAction" value="/addBrewery" />
	<form:form action="${formAction}" method="POST"
		modelAttribute="addBrewery">
		<table>
					<tr>
				<th><label for="owners_user_id">Owners ID</label></th>
				<td><form:select path="owners_user_id">
						<form:option value="999999">Select the account associated with this Brewery</form:option>
						<c:forEach var="brewer" items="${allBrewers}">
							<form:option value="${brewer.id}">${brewer.id} - ${brewer.userName}</form:option>
						</c:forEach>
					</form:select></td>
			</tr>
			<tr>
				<th><label for="breweryName">Brewery Name</label></th>

				<td><form:input path="name" name="name"
						placeholder="Brewery's Name" size="35" />
						<form:errors path="name" /><br /></td>
			</tr>

			<tr>
				<th><form:label path="email">Brewery Email</form:label></th>
				<td><form:input path="email" name="email"
						placeholder="Enter Your Email" size="35" />
						<form:errors path="email" />
						<br /></td>
			</tr>

			<tr>
				<th><form:label path="address">Brewery Address</form:label></th>
				<td><form:input path="address" name="address"
						placeholder="Enter Your Address" size="35" />
						<form:errors path="address" /><br /></td>
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
						placeholder="Enter A Description" size="50" />
						<form:errors path="description" /><br /></td>
			</tr>

		</table>
		<input type="submit" value="Submit" />
	</form:form>
</div>

</c:if>
<c:if test="${currentUser.role != 'admin' }">
This page is only for admins
</c:if>
<%@include file="footer.jsp"%>