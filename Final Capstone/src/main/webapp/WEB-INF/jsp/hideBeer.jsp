<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>

<c:if test="${currentUser.role == 'brewer' }">
<div class="hide-beer">
	<c:url var="formAction" value="/hideBeer" />
	<form action="${formAction}" method="POST" >
		<table>
		<tr>
  			<th><label for="beer_id">Beer to hide:</label></th>
			<td><select name="beer_id" >
					<option value="9999999">Select the beer you want to hide</option>
				  	<c:forEach var="beer" items="${allBeers}">
				  	<c:if test = "${beer.active ==true }">
						<option value="${beer.beer_id}">${beer.beer_id} ${beer.name}</option>
						</c:if>
					</c:forEach>  
				</select>   </td>
		</tr> 
		</table>
		<input type="submit" value="Submit" />
	</form>
</div>
<br>

<div class="unhide-beer">
	<c:url var="formAction" value="/hideBeer" />
	<form action="${formAction}" method="POST" >
		<table>
		<tr>
  			<th><label for="beer_id">Beer to bring back:</label></th>
			<td><select name="beer_id" >
					<option value="9999999">Select the beer you want to make active</option>
				  	<c:forEach var="beer" items="${allBeers}">
				  	<c:if test = "${beer.active ==false }">
						<option value="${beer.beer_id}">${beer.beer_id} ${beer.name}</option>
						</c:if>
					</c:forEach>  
				</select>   </td>
		</tr> 
		</table>
		<input type="submit" value="Submit" />
	</form>
</div>
</c:if>
<c:if test="${currentUser.role != 'brewer' }">
Please log in with your brewer account to  access this page

</c:if>
<%@include file="footer.jsp"%>