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

  // hide 
  $('#profile').hide();
  $('#new').hide();
  $('#main-graph').show();

  // hide profile, show form
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
