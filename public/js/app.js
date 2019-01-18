'use strict';

$(() => {

  function eventHelper(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  function toggleProfileForm() {
    $('#profile').toggle();
    $('#new').toggle();
  }

  // hide profile, show form
  $('#new').hide();
  $('#profile button').on('click', e => {
    eventHelper(e);
    toggleProfileForm();
  });

  // hide form, show profile
  $('a.cancel').on('click', e => {
    eventHelper(e);
    toggleProfileForm();
  });

});

var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 47.630, lng: -122.350},
    zoom: 14
  });
}


// initMap();
