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

  function toggleLoginForm(){
    $('#login').toggle();
    $('#createUser').toggle();
  }
  
  $('#createUser').hide();
  $('#toggleLogin').on('click', e => {
    eventHelper(e);
    toggleLoginForm();
  });
});
