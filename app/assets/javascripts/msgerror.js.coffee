class MsgError
  constructor: (message) ->
    ($ ".message").remove()
    @displayMessage(message)

  displayMessage: (message) ->
    ($ "<div class='message alert'>#{message}</div>")
      .fadeIn('slow').prependTo('body');

    window.setTimeout @hideMessage, 2000

  hideMessage: ->
    ($ '.message').fadeOut 'slow', ->
     ($ '.message').remove()

App.Utilities.MsgError = MsgError
