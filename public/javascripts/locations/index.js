var confirmingLocation;

$('#locations ul a').live('click', function (e) {
  if(!e.ctrlKey && !e.metaKey) {
    e.preventDefault();
    confirmingLocation = $(this).parent();
    $('#location-confirmation').find('iframe').
      attr('src', this.href).end().show();
    $(document.body).addClass('location-confirmation-showing');
  }
});

$('#location-confirmation iframe').mouseenter(function () {
  $('#location-confirmation').addClass('show-all');
});

$('#location-confirmation').mouseleave(function () {
  $('#location-confirmation').removeClass('show-all');
});

$('#locations form.new-sighting').live('submit', function (e) {
  var link = $(this).parent().find('a'),
    message = "This will create a new sighting at the following location:\n\n" + 
    link.text() + "\n" + link.attr('href') + "\n\n" +
    "Are you sure you wish to do this?"
  if(!confirm(message)) {
    e.preventDefault();
  }
});

$('#locations form.new-all-clear').live('submit', function (e) {
  var form = $(this);
  form.find('input').addClass('loading');
  $.post(this.action, form.serialize(), processReload);
  e.preventDefault();
});

function closeLocationConfirmation() {
  $('#location-confirmation').hide().find('iframe').attr('src', 'about:blank');
  $(document.body).removeClass('location-confirmation-showing');
}

function willCompleteConfirmation(form_class) {
  return function (e) {
    var form;
    form = confirmingLocation.find('form.' + form_class);
    form.submit();
    confirmingLocation = null;
    closeLocationConfirmation();
    e.preventDefault();
  }
}

$('#confirm-sighting').click(willCompleteConfirmation('new-sighting'));

$('#deny-sighting').click(willCompleteConfirmation('new-all-clear'));

function startReload() {
  $('a.reload-button').addClass('loading');
  $.get('/locations', processReload);
}

function processReload(html) {
  var wrapper = $('<div/>', {html: html});
  $('#locations').html(wrapper.find('#locations').html());
  $('a.reload-button').removeClass('loading');
}

$('a.reload-button').click(function (e) {
  startReload();
  e.preventDefault();
});

setInterval(startReload, 30000);
