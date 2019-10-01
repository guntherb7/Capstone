<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<title>Brewery Info Central</title>
<c:url var="bootstrapCss" value="/css/bootstrap.min.css" />
<c:url var="siteCss" value="/css/site.css" />

<c:url var="jQueryJs" value="/js/jquery.min.js" />
<c:url var="jqValidateJs" value="/js/jquery.validate.min.js" />
<c:url var="jqvAddMethJs" value="/js/additional-methods.min.js" />
<c:url var="jqTimeagoJs" value="/js/jquery.timeago.js" />
<c:url var="popperJs" value="/js/popper.min.js" />
<c:url var="bootstrapJs" value="/js/bootstrap.min.js" />

<link rel="stylesheet" type="text/css" href="${bootstrapCss}">
<link rel="stylesheet" type="text/css" href="${siteCss}">

<script src="${jQueryJs}"></script>
<script src="${jqValidateJs}"></script>
<script src="${jqvAddMethJs}"></script>
<script src="${jqTimeagoJs}"></script>
<script src="${popperJs}"></script>
<script src="${bootstrapJs}"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("time.timeago").timeago();

		$("#logoutLink").click(function(event) {
			$("#logoutForm").submit();
		});

		var pathname = window.location.pathname;
		$("nav a[href='" + pathname + "']").parent().addClass("active");

	});
</script>

<link
	href="https://fonts.googleapis.com/css?family=Domine|Montserrat:500,600,700&display=swap"
	rel="stylesheet">
</head>


<!-- Bootstrap Navbar -->


<!-- Toggler Button -->
<!-- <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button> -->
<div class="navigation">

	<div class="logo-image">
		<img src="<%=request.getContextPath()%>/img/brewerfinderlogo.png">
	</div>


	<nav class="navbar sticky-top navbar-light">
		<c:url var="homePageHref" value="/" />
		<a class="navbar-brand" href="${homePageHref}">Brewery Finder</a>
		


		<!-- Temporary Logo until one is decided upon -->
		<%-- <a href="${homePageHref}" class="navbar-left"><img src="src/main/webapp/img/brewerfinderlogo"></a> --%>

		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<c:url var="homePageHref" value="/" />
				<a class="nav-link" href="${homePageHref}">Home</a>


				<!-- Displays if current user is registered and logged in -->

				<c:if test="${not empty currentUser}">
					<%--   	<c:url var="dashboardHref" value="/users/${currentUser}" />
	  	<a class="nav-link" href="${dashboardHref}">Private Messages</a>
  	<c:url var="newMessageHref" value="/users/${currentUser}/messages/new" />
	 	 <a class="nav-link" href="${newMessageHref}">New Message</a>
  	<c:url var="sentMessagesHref" value="/users/${currentUser}/messages" />
  	 	 <a class="nav-link" href="${sentMessagesHref}">Sent Messages</a>
  	<c:url var="changePasswordHref" value="/users/${currentUser}/changePassword" />
	 	 <a class="nav-link" href="${changePasswordHref}">Change Password</a> --%>

					<c:if test="${currentUser.role == 'brewer' }">
						<c:url var="editMyBrewery"
							value="/updateSpecificBrewery?userId=${currentUser.id}" />
						<a class="nav-link" href="${editMyBrewery}">Edit My Brewery</a>
						<%-- 	<c:url var="editMyBreweryBeers" value="/updateSpecificBrewery?userId=${currentUser.id}" />
	<a class="nav-link" href="${editMyBreweryBeers}">Edit My Beers</a>	 --%>
					</c:if>

					<c:if test="${currentUser.role == 'admin' }">
						<c:url var="addBrewery" value="/addBrewery" />
						<a class="nav-link" href="${addBrewery}">Add a brewery</a>
						<c:url var="editBrewerys" value="/updateBrewery" />
						<a class="nav-link" href="${editBrewerys}">Edit breweries</a>
						<c:url var="updateBeerMaster" value="/updateBeerMaster" />
						<a class="nav-link" href="${updateBeerMaster}">Edit beers</a>

					</c:if>

				</c:if>

				<!-- Displays if user is currently not registered or logged in -->

				<c:choose>
					<c:when test="${empty currentUser}">
						<c:url var="newUserHref" value="/users/new" />
						<a class="nav-link" id="Signup" href="${newUserHref}">Sign Up</a>
						<c:url var="loginHref" value="/login" />
						<a class="nav-link" id="login" href="${loginHref}">Log In</a>
					</c:when>

					<c:otherwise>
						<c:url var="logoutAction" value="/logout" />
						<form id="logoutForm" action="${logoutAction}" method="POST">
							<input type="hidden" name="CSRF_TOKEN" value="${CSRF_TOKEN}" />
						</form>
						<a id="logoutLink" href="#" class="nav-link">Log Out</a>
					</c:otherwise>
				</c:choose>



			</div>
		</div>
	</nav>
	<c:if test="${not empty currentUser}">
		<p id="currentUser">You're currently logged in as:
			${currentUser.userName}</p>

	</c:if>

</div>
<body>