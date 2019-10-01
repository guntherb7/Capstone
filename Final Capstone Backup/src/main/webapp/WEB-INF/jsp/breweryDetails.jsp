<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="header.jsp"%>
<c:if test="${noNews == false}">
	<div style="width: 20%; float: right; valign: top; padding-left: 15px;">
		<h3>BREW NEWS</h3>
		<br>
		<div id="brewnews">
			<c:forEach var="update" items="${breweryUpdates}">
				<p>
					<u><c:out value="${update.value }" /></u> <br>
					<c:out value="${update.key}" />
				</p>

			</c:forEach>
		</div>
	</div>

	<div class="brewery-details" style="width: 80%;">
</c:if>
<div class="brewery-details">
	<h1>
		<c:out value="${brewery.name}"></c:out>
	</h1>
	<br>
	<p>
		<c:out value="${brewery.address}" />
	</p>
	<div class="about-brewery">
		<br>
		<h4 id="about">ABOUT THIS BREWERY</h4>
	</div>
	<div class="well well-large">
		<c:out value="${brewery.description}" />
	</div>
	<a href=mailto:${brewery.email}>${brewery.email}</a> <br>
	<hr>

</div>

</div>

<h3>OUR BEER LIST</h3>
<br>
<div class="brewery-beers">
	<c:forEach var="beer" items="${breweryBeers}">
		<div class="beer-details">
			<c:choose>
				<c:when test="${beer.active == true}">
					<c:url var="beerDetails"
						value="/beerDetails?beerId=${beer.beer_id}" />
					<div class="beer-details-sub">
						<a href="${beerDetails}" class="btn btn-primary btn-lg active"
							role="button" aria-pressed="true"><c:out value="${beer.name}" /></a>
					</div>

					<table>
						<tr>
							<th><u>Style</u></th>
							<th><u>ABV</u></th>
						</tr>
						<tr>
							<td><span class="badge badge-success">${beer.style}</span></td>
							<td><span class="badge badge-important"> ${beer.abv}%</span></td>
						</tr>
					</table>

					<br>
					<p>
						<c:out value="${beer.description}" />
					</p>
					<hr>

				</c:when>
			</c:choose>

		</div>
	</c:forEach>
</div>

<html>


<script>
	var map;
	function initialize() {
		map = new google.maps.Map(document.getElementById('map-canvas'), {
			center : {
				lat : 39.9612,
				lng : -82.9988
			},
			zoom : 10
		});
	
		 var iconBase =
	            'http://maps.google.com/mapfiles/ms/icons/';

	        var icons = {
	         /*  parking: {
	            icon: iconBase + 'parking_lot_maps.png'
	          }, */
	        
	          bar: {
	            icon: iconBase + 'bar.png'
	          }
	        };

	        var features = [
	          {
	            position: new google.maps.LatLng(${brewery.gpslocation}),
	            type: 'bar',
	            
	            
	          },
	          
	        ];
	        
	     // Create markers.
	        for (var i = 0; i < features.length; i++) {
	          var marker = new google.maps.Marker({
	            position: features[i].position,
	            animation: google.maps.Animation.BOUNCE,
	            
	            icon: icons[features[i].type].icon,
	            map: map
	          });
	          var infowindow = new google.maps.InfoWindow({
	        	    content: '${brewery.name} <br>${brewery.address}'
	        	  });
	          setTimeout(function(){ marker.setAnimation(null); }, 5000);

	          marker.addListener('click', function() {
	              map.setZoom(16);
	              map.setCenter(marker.getPosition());
	              infowindow.open(map, marker);
	            });
	        };
	        
	      };

	
</script>
<body>
	<div id="map-canvas" style="height: 300px; width: 600px;"></div>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyByRwnJ0-n0nBJ7b8CbSZWH8pQQe0Zp098&callback=initialize"
		async defer></script>

</body>
</html>


<%@include file="footer.jsp"%>