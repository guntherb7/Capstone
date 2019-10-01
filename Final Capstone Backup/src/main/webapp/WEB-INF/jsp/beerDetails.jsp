<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@include file="header.jsp"%>

<div class="beer-details">

	<h1>
		<c:out value="${beer.name}"></c:out>

	</h1>
	<table>
		<tr>
			<th><a>Style</a></th>
			<th><a>ABV</a></th>
		</tr>
		<tr>
			<td><span class="badge badge-warning">${beer.style}</span></td>
			<td><span class="badge badge-important">${beer.abv}%</span></td>
		</tr>
	</table>
	<br>
	<p>
		<c:out value="${beer.description}" />
		<c:if test="${totalRating > 0}">
			<br>
			<br>
		Average customer rating =
					<c:set var="count2" value="1" />
			<td><c:forEach begin="1" end="5">
					<c:choose>
						<c:when test="${totalRating/numberOfReviews >= count2 }">
							<span class="rating filled">&#9734;</span>
						</c:when>
						<c:otherwise>
							<span class="rating">&#9734;</span>
						</c:otherwise>
					</c:choose>
					<c:set var="count2" value="${count2 + 1 }" />
				</c:forEach></td>
		</c:if>
	</p>
	<hr>
</div>
<div class="beer-reviews">
	<div class="beer-avg-rating">
		<h4>

			<c:if test="${numberOfReviews == 0}">
				<c:if test="${currentUser.id != brewery.owners_user_id}">Be the first person to review this beer below!</c:if>
			</c:if>
			<c:if test="${numberOfReviews == 1}">REVIEW:</c:if>
			<c:if test="${numberOfReviews > 1}">REVIEWS:</c:if>
		</h4>

		<c:forEach var="review" items="${reviews}">
			<h4>
				<c:out value="${review.name}" />
			</h4>
			<c:set var="count" value="1" />
			<td><c:forEach begin="1" end="5">
					<c:choose>
						<c:when test="${review.rating >= count }">
							<span class="rating filled">&#9734;</span>
						</c:when>
						<c:otherwise>
							<span class="rating">&#9734;</span>
						</c:otherwise>
					</c:choose>
					<c:set var="count" value="${count + 1 }" />
				</c:forEach></td>
			<br>
			<br>
			<p>
				<c:out value="${review.review}" />
			</p>

			<c:if test="${review.brewer_response != null}">
				<br>
				<p>
					Response to
					<c:out value="${review.name}" />
					from the owner of
					<c:out value="${brewery.name}" />
					-
				</p>
				<i><c:out value="${review.brewer_response}" /></i>

			</c:if>

			<c:if test="${currentUser.id == brewery.owners_user_id}">
				<div class="beer-review-form">
					<c:url value="/submitReviewResponse" var="submitReviewResponseUrl" />
					<form action="${submitReviewResponseUrl}" method="POST">
						<c:if test="${not empty review.brewer_response}">	Update</c:if>
						<c:if test="${empty review.brewer_response}">	Enter</c:if>
						your response to this review from ${review.name}: <input
							type="hidden" name="review_id" value="${review.review_id}">
						<input type="hidden" name="beerId" value="${beer.beer_id}">
						&ensp;<input type="text" name="brewer_response" size="50"
							placeholder="Enter your response here"> <input
							type="submit" value="Submit">

					</form>

				</div>
			</c:if>
			<hr>
		</c:forEach>

	</div>
</div>

<c:if test="${currentUser.role != 'brewer' }">
	<div class="beer-review-form">
		<c:url value="/submitReview" var="reviewSubmitUrl" />
		<form action="${reviewSubmitUrl}" method="POST">
			Name:<br> <input type="hidden" name="beer_id"
				value="${beer.beer_id}"> <input type="text" name="name"
				value="Enter Your Name" placeholder="Enter Your Name"><br>
			Rating:<br> <input type="number" min="1" max="5" name="rating"
				placeholder="5"> <br> Review Text:<br>
			<textarea maxlength="900" rows="10" cols="50" name="review"
				placeholder="Enter your review here. Max 900 characters."></textarea>
			<br> <br> <input type="submit" value="Submit">
		</form>
	</div>
	<br>
	<hr>
	<br>
</c:if>

<%@include file="footer.jsp"%>