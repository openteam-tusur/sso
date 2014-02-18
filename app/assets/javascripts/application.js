// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function hide_flash_block() {
  $('#flash_block').slideUp(function() {
    $(this).remove();
  });
};

function init_auth() {
  var draw_popup, save_comment;
  draw_popup = function(url, width, height, name) {
    var left, top;
    left = (screen.width / 2) - (width / 2);
    top = (screen.height / 2) - (height / 2);
    return window.open(url, name, "menubar=no,toolbar=no,status=no,width=" + width + ",height=" + height + ",toolbar=no,left=" + left + ",top=" + top);
  };
  $('.social_auth_link').not('.charged').addClass('charged').on('click', function(evt) {
    var target;
    target = $(evt.target);
    draw_popup(target.attr('href'), 700, 400, 'Авторизация');
    return false;
  });
};

$(function() {
  $('#flash_block').click(function() {
    hide_flash_block();
  });
  $("#flash_block").stop(true, true);
  setTimeout("hide_flash_block();", 20000);
  init_auth();
});
