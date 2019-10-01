<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%@include file="homeHeader.jsp"%>



<div class="brewery-list">
	<c:forEach var="brewery" items="${breweries}">
		<div class="brewery">
			<div class="brewery-info">
				<c:url var="breweryDetails"
					value="/breweryDetails?breweryId=${brewery.brewery_id}" />
				<h2>
					<a href="${breweryDetails}" class="btn btn-primary btn-lg active"
						role="button" aria-pressed="true"><c:out
							value="${brewery.name}" /></a>
				</h2>





				<div class="address">
					<c:out value="${brewery.address}" />
				</div>
				<br> <br> <u><span class="badge badge-info">ABOUT
						THIS BREWERY</span></u> <br> <br>
				<div class="alert alert-success" role="alert">
					<i><c:out value="${brewery.description}" /></i>
				</div>
				<a href=mailto:${brewery.email}>${brewery.email}</a> <br>
				<hr>
				<br>
			</div>
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
			zoom : 10.5
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
	        	<c:forEach var="brewery" items = "${breweries}">
	          {
	       
	            position: new google.maps.LatLng(${brewery.gpslocation}),
	            type: 'bar',
	            //label: '${brewery.name}',
	            url: "breweryDetails?breweryId=${brewery.brewery_id}"
	          },</c:forEach>
	          
	        ];
	        
	     // Create markers.
	        for (var i = 0; i < features.length; i++) {
	          var marker = new google.maps.Marker({
	            position: features[i].position,
	            animation: google.maps.Animation.DROP,
	            icon: icons[features[i].type].icon,
	            map: map,
	            //label: features[i].label,
	            url: features[i].url
	          });
	          var infowindow = new google.maps.InfoWindow({
	        	    content: '${brewery.name} <br>${brewery.address}'
	        	  });
	          google.maps.event.addListener(marker, 'click', function() {
	              
	        	  window.location.href = this.url;
	              
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