'use strict';

$(() => {

  function eventHelper(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  // hide profile, show form
  $('#profile').hide();
  // $('#new').hide();
  $('#profile button').on('click', e => {
    eventHelper(e);

    $('#profile').hide();
    $('#new').show();
  });

});