$( document ).on('turbolinks:load', init)

function init() {
  $( ".column-content" ).sortable( {
    revert: true,
    receive: function(event, ui) {
      var card_id = ui.item.attr('id');
      var parent_id = ui.item.parents('.column').attr('id');
      var container = ui.item.parent().children();
      var i = 0, pos;
      while(container[i].id != card_id)i+=1;
      if(container.length == 1)pos = (1 << 16);
      else if(i == 0)pos = container[i+1].getAttribute('pos') / 2;
      else if(i + 1 == container.length)pos = container[i-1].getAttribute('pos') * 2;
      else pos = (container[i-1].getAttribute('pos') + container[i+1].getAttribute('pos')) / 2;
      container[i].setAttribute('pos', pos);
      console.log(container[i]);
      $.ajax({
        url: '/cards/' + card_id,
        data: {
         'card': {
                   'list_id': parent_id,
                   'position': pos,
                 },
        },
        type: 'patch',
        success: function (response) {
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
