function success(text) {
    $('.notif').fadeIn().delay(2000).fadeOut('slow').html('<div class="alert alert-success role="alert"">' + text + '</div>');
}

function error(text) {
    $('.notif').fadeIn().delay(2000).fadeOut('slow').html('<div class="alert alert-danger role="alert"">' + text + '</div>');
}

function warning(text) {
    $('.notif').fadeIn().delay(2000).fadeOut('slow').html('<div class="alert alert-warning role="alert"">' + text + '</div>');
}