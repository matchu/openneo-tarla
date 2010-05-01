function preventDefault(fn) {
  return function (e) {
    e.preventDefault();
    fn();
  }
}

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

var reload_button = $('a.reload-sightings-button').show().
  click(preventDefault(reloadSightings));

function reloadSightings() {
  reload_button.addClass('loading');
  $.get('/sightings', function (html) {
    reload_button.removeClass('loading');
    var sightings = $(html).find('#sightings');
    $('#no-sightings').toggleClass('hidden', sightings.find('li').length > 0);
    $('#sightings').html(sightings.html());
  });
}

setInterval(reloadSightings, 30000);
