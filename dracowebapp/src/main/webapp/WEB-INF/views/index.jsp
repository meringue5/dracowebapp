<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0">
<title>Draconian World</title>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Hind|Oxygen" rel="stylesheet">
<style>
/* body { */
/* 	margin:0; */

/* } */

nav {
	background-color:crimson;
	width:100%;
	margin:0; 
/* 	top:0; */
/* 	left:0; */
}

nav li {
	display:inline-block;
}

nav a {
	text-decoration:none;
	font-family: 'Hind', sans-serif;
 	font-size:1.3em;
 	font-weight:bold;
	color:white;
	margin-right:1em;
}

nav a:hover {
	color:red;
}

h1, p {
	font-family: 'Oxygen', sans-serif;
}

#map {
	float:left;
	margin-right:2em;
	width:30%;
    height:500px;
  }
</style>
</head>
<body>
	<nav>
		<ul>
		<li>
		<a href="/board/boardList?bgno=1">board</a>
		</li>
		<li>
		<a href="/jenkins">jenkins</a>
		</li>	
		<li>
		<a href="/JSPWiki">wiki</a>
		</li>
		</ul>
	</nav>
    <div id="map"></div>
    <script>
      function initMap() {
        var uluru = {lat: -25.363, lng: 131.044};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDCuLljLjNPBi-LC1kJkzQl_0L87LILF0M&callback=initMap">
    </script>
<!-- 	<h1>Welcome to the Draconian World</h1> -->
<!-- 	<p>The creator of this page may not be as smart as his colleagues. A diligent one neither. However, his destiny has led him to throw himself into harsh iteration of trials and failures, which always has refined his skills and concept more elaborate and enhanced. (I mean it's just relatively better when compared to the prior trials) Behold what's happening here. -->
<!-- 	</p> -->
<!-- 	<p>No, don't expect anything, just in order to not get disappointed.</p> -->

</body>
</html>