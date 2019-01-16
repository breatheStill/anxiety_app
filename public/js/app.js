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


  // get oist of jQuery objedts
  const components = [
    '#mainGraph',
    '#profile',
    '#new',
  ];

  function showPage (page) {
    components.forEach(element => {
      if (element === page) $(`${element}`).show();
      else $(`${element}`).hide();
    });
  }

  // hide profile, show form
  $('#profile button').on('click', e => {
    eventHelper(e);
    // toggleProfileForm();
    showPage('#new');
  });

  // hide form, show profile
  $('a.cancel').on('click', e => {
    eventHelper(e);
    // toggleProfileForm();
    showPage('#profile');
  });

  $('#smallGraph').on('click', e => {
    eventHelper(e);
    // $('#profile').hide();
    // $('canvas#myMainChart').show();
    // $('#mainGraph').show();
    showPage('#mainGraph');
  });

   showPage('#profile');

  });
