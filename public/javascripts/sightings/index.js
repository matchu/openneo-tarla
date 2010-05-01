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
