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
        statusCode:
          422: (data) ->
            new App.Utilities.MsgError(data.responseJSON)

      e.stopImmediatePropagation()

    $('.order_detail .payment').on 'click', (e) ->
      id = $(@).parent().parent().attr('data-orderdetail-id')
      paid = if $(@).children().attr('class') in ['pay'] then false else true

      $.ajax
        url: document.URL + "/order_details/#{id}"
        type: 'PUT'
        data: { order_details: { payment: paid } }
        statusCode:
          422: (data) ->
            new App.Utilities.MsgError(data.responseJSON['payment'][0])

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
      status = $(@).find('option:selected').attr('value')

      $.ajax
        url: document.URL
        type: 'PUT'
        data: { order: { status: status } }
        statusCode:
          422: (data) ->
            new App.Utilities.MsgError(data.responseJSON['payment']['0'])
      e.stopImmediatePropagation()

    $('#payment').on 'click', (e) ->
      $.ajax
        url: document.URL
        type: 'PUT'
        data: { order: { payment: true } }
        statusCode:
          422: (data) ->
            new App.Utilities.MsgError(data.responseJSON['payment'][0])

      e.stopImmediatePropagation()


App.Utilities.Order = Order
