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

$(function() {
  $('#flash_block a').click(function() {
    hide_flash_block();
  });
  $("#flash_block").stop(true, true);
  setTimeout("hide_flash_block();", 20000);
});
