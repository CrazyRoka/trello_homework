$( document ).on('turbolinks:load', init)

function init() {
  $( ".column-content" ).sortable( {
    revert: true,
    connectWith: ".column-content",
    update: function(event, ui) {
      if (this === ui.item.parent()[0]){
        var card_id = ui.item.attr('id');
        var parent_id = ui.item.parents('.column').attr('id');
        var container = ui.item.parent().children();
        var i = 0, pos;
        while(container[i].id != card_id)i+=1;
        if(container.length == 1)pos = (1 << 16);
        else if(i == 0)pos = container[i+1].getAttribute('pos') / 2;
        else if(i + 1 == container.length)pos = (1 << 16) + parseInt(container[i-1].getAttribute('pos'));
        else pos = (parseInt(container[i-1].getAttribute('pos'))
                    + parseInt(container[i+1].getAttribute('pos'))) / 2;
        container[i].setAttribute('pos', pos);
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
    }
  } );
  $( ".column-content, .board" ).disableSelection();

  $( ".board" ).sortable( {
    revert: true,
    items: '> div:not(.pin)',
    update: function(event, ui) {
      var list_id = ui.item.attr('id');
      var container = ui.item.parent().children();
      var i = 0, pos;
      while(container[i].id != list_id)i+=1;
      if(container.length == 2)pos = (1 << 16);
      else if(i == 0)pos = container[i+1].getAttribute('pos') / 2;
      else if(i + 2 == container.length)pos = (1 << 16) + parseInt(container[i-1].getAttribute('pos'));
      else pos = (parseInt(container[i-1].getAttribute('pos'))
                  + parseInt(container[i+1].getAttribute('pos'))) / 2;
      container[i].setAttribute('pos', pos);
      $.ajax({
        url: '/lists/' + list_id,
        data: {
         'list': {
                   'position': pos,
                 },
        },
        type: 'patch',
        success: function (response) {
        }
      } );
    }
  } );
}
