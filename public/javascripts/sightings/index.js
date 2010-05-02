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
    var sightings_list = $('<div/>', {html: html}).find('#sightings'),
      sightings = sightings_list.find('li');
    sightings.each(function () {
      var li = $(this);
      if(!document.getElementById(li.attr('id'))) {
        notifier.notify(li.find('a').text());
      }
    });
    $('#sightings').html(sightings_list.html());
    $('#no-sightings').toggleClass('hidden', sightings.length > 0);
  });
}

setInterval(reloadSightings, 30000);

/*
 *   Notifications
 */
 
var wn = window.webkitNotifications, notifiers = {
  alert: function AlertNotificationDriver() {},
  title: function TitleNotificationDriver() {},
  webkit: function WebkitNotificationDriver() {}
}, notifier = new notifiers.title(), has_focus = true;

notifiers.alert.prototype.notify = function (text) {
  alert("New Tarla Sighting!\n===================\n\n" + text);
}

notifiers.title.prototype.notify = function (text) {
  var title = document.title, favicons = [
    $('#favicon'),
    $('#favicon').clone().attr('href', '/favicon_flash.ico')
  ];
  function flashTitle(toggle) {
    if(!toggle || (toggle && !has_focus)) {
      $('#favicon').replaceWith(favicons[toggle ? 1 : 0]);
      document.title = toggle ? ('New Tarla Sighting! ' + text) : title;
      setTimeout(function () { flashTitle(!toggle) }, 500);
    }
  }
  flashTitle(true);
}

notifiers.webkit.prototype.notify = function (text) {
  wn.createNotification(
    '/images/tarla_notification.png',
    'New Tarla Sighting!',
    text
  ).show();
}

function willSetFocus(bool) { return function () { has_focus = bool } }

$(window).focus(willSetFocus(true)).blur(willSetFocus(false));

if(wn) {
  if(wn.checkPermission() == 0) {
    notifier = new notifiers.webkit();
  } else {
    var permission_el = $('#request-notification-permission').show();
    permission_el.find('a').click(function () {
      wn.requestPermission(function () {
        if(wn.checkPermission() == 0) {
          permission_el.hide('fast');
        }
      });
    });
  }
}
