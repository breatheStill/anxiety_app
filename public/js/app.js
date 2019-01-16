'use strict';

$(() => {
  function eventHelper(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  // a list of jQuery objedts
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

  // show form
  $('#profile button').on('click', e => {
    eventHelper(e);
    showPage('#new');
  });

  // show profile
  $('a.cancel').on('click', e => {
    eventHelper(e);
    showPage('#profile');
  });

  // show main chart
  $('#smallGraph').on('click', e => {
    eventHelper(e);
    showPage('#mainGraph');
  });

    // render profile page on first visit
   showPage('#profile');



  });
