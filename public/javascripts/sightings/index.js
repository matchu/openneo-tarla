/*
 *   Basic layout hooks
 */

$('#new-sighting input[type=text]').placeholder().focus(function () {
  $('#before-you-submit').slideDown('fast');
}).blur(function () {
  $('#before-you-submit').slideUp('fast');
});

$('#new-sighting').submit(function () {
  var field = this['sighting[url]'];
  
  if(field.value == field.getAttribute('placeholder')) {
    field.value = '';
  }
});

/*
 *   AJAX reload sightings
 */

function reloadSightings(callback) {
  $.get('/sightings', function (html) {
    var sightings = $(html).find('#sightings');
    $('#no-sightings').toggleClass('hidden', sightings.find('li').length > 0);
    $('#sightings').html(sightings.html());
    if(callback !== undefined) callback();
  });
}

$('a.reload-sightings-button').show().click(function (e) {
  var el = $(this);
  e.preventDefault();
  el.addClass('loading');
  reloadSightings(function () {
    el.removeClass('loading');
  });
});
