var map;

function initMap(lat = 47.630, lng = -122.350) {
  console.log(lat,lng)
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat , lng},
    zoom: 14
  });
}

function GetLatlong(){
  var geocoder = new google.maps.Geocoder();
  var address = document.getElementById('localForm').name;

  geocoder.geocode({ 'address': address }, function (results, status) {

    if (status == google.maps.GeocoderStatus.OK) {
      var latitude = results[0].geometry.location.lat();
      var longitude = results[0].geometry.location.lng();

    }
  });
}

window.onload = () => {

  var handle = document.getElementById('localForm');

  handle.addEventListener('submit', function(event) {
    event.preventDefault();
    console.log(event.target.search.value)
  });
}