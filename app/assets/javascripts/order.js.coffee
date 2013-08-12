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


App.Utilities.Order = Order
