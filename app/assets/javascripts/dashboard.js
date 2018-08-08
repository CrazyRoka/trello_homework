$( document ).on('turbolinks:load', init)

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
    stack: "div",
  } );
}
