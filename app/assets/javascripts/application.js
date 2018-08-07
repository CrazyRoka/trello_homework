// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require jquery-ui
$( init );

function init() {
  $( ".column-content" ).sortable( {
    revert: true,
    receive: function(event, ui) {
      var card_id = ui.item.attr('id');
      var parent_id = ui.item.parents('.column').attr('id');
      $.ajax({
        url: '/cards/' + card_id,
        data: {
         'card': {
                   'list_id': parent_id
                 }
        },
        type: 'patch',
        success: function (response) {
         // var list = response.tags;
         // self.trigger(
         //   'setSuggestions',
         //   { result : textext.itemManager().filter(list, query) }
         // );
        }
      } );
    }
  } );
  $( ".column-content" ).disableSelection();
  $('.column-content .card').draggable( {
    //containment: '.board',
    cursor: 'move',
    revert: "invalid",
    connectToSortable: ".column-content",
  } );
}
