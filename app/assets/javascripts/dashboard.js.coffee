class HideMessages
  constructor: ->
    window.setTimeout @items, 1500

  items: ->
    $('.alert, .notice').fadeOut 'slow', ->
     $(@).remove();


App.Utilities.HideMessages = HideMessages
