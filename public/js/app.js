'use strict';

$(() => {
  function eventHelper(e) {
    e.preventDefault();
    e.stopPropagation();
  }

  // a list of elements
  const components = [
    '#mainGraph',
    '#profile',
    '#new',
  ];

  function showPage(page) {
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
    $('.content>.entry-edit').remove();
    showPage('#profile');
  });

  // show main chart
  $('#smallGraphContainer').on('click', e => {
    eventHelper(e);
    showPage('#mainGraph');
  });

  // render profile page on first visit
  showPage('#profile');



  // toggle full/preview/edit journal entries
  $('.entry-full').hide();
  $('.entry-edit').hide();

  $('.preview').on('click', e => {

    const jid = e.target.closest('div').id.split('-')[1];
    $('.preview').hide();
    $(`#entry-${jid}`).show();
  });

  $('a.return').on('click', e => {
    eventHelper(e);
    $(e.target).closest('.entry-full').hide();
    $('.preview').show();
  })


  // populate update form with journal info
  $('a.update').on('click', e => {
    eventHelper(e);
    // console.log(e.target.closest('div.entry-full').id);
    const jid = e.target.closest('div.entry-full').id.split('-')[1];
    const form = $(`#edit-${jid}`).clone(true, true);
    form.appendTo($('.content'));
    $('#profile').hide();
    form.show();
  });

});

var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 47.630, lng: -122.350 },
    zoom: 14
  });
}


  // initMap();
