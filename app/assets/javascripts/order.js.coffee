class Order
  constructor: ->
    $('.food').on 'click', ->
      establishment_id = $('#foods').attr('data-establishment-id')
      food_id = $(@).attr('data-food-id')

      $.post document.URL + '/order_details',
        order_details:
          food_id: food_id
      .done (data) ->
        console.log(data)

    $('.order_detail .remove').on 'click', ->
      id = $(@).parent().parent().attr('data-orderdetail-id')

      $.ajax
        url: document.URL + "/order_details/#{id}"
        type: 'DELETE'

    $('.quantity').change (e) ->
      food_id = $($(@).parents()[2])
      $.ajax
        url: document.URL + "/order_details/#{food_id.attr('data-orderdetail-id')}"
        type: 'PUT'
        data: { order_details: { quantity: $(@).val() }}
      e.stopPropagation()


App.Utilities.Order = Order
