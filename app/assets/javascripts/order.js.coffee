class Order
  constructor: ->
    $('.food').on 'click', (e) ->
      establishment_id = $('#foods').attr('data-establishment-id')
      food_id = $(@).attr('data-food-id')
      $.post document.URL + '/order_details',
        order_details:
          food_id: food_id
      .error (errors) ->
        for error in errors
         new App.Utilities.MsgError(error)
      e.stopImmediatePropagation()

    $('.order_detail .remove').on 'click', (e) ->
      id = $(@).parent().parent().attr('data-orderdetail-id')
      $.ajax
        url: document.URL + "/order_details/#{id}"
        type: 'DELETE'
      e.stopImmediatePropagation()

    $('.order_detail .payment').on 'click', (e) ->
      id = $(@).parent().parent().attr('data-orderdetail-id')
      paid = if $(@).children().attr('class') in ['pay'] then false else true
      $.ajax
        url: document.URL + "/order_details/#{id}"
        type: 'PUT'
        data: { order_details: { payment: paid } }
      e.stopImmediatePropagation()

    $('.quantity').change (e) ->
      food_id = $($(@).parents()[2])
      $.ajax
        url: document.URL + "/order_details/#{food_id.attr('data-orderdetail-id')}"
        type: 'PUT'
        dataType: 'json'
        data: { order_details: { quantity: $(@).val() }}
        statusCode:
          422: (data) ->
            new App.Utilities.MsgError(data.responseJSON['quantity'][0])
      e.stopImmediatePropagation()

    $('#status').change (e) ->
      status_id = $(@).find('option:selected').attr('value')
      $.ajax
        url: document.URL
        type: 'PUT'
        data: { order: { status: status_id } }
      e.stopImmediatePropagation()

    $('#payment').on 'click', (e) ->
      $.ajax
        url: document.URL
        type: 'PUT'
        data: { order: { payment: true } }
      e.stopImmediatePropagation()


App.Utilities.Order = Order
