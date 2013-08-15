class MsgError
  constructor: (message) ->
    @displayMessage(message)

  displayMessage: (message) ->
    ($ "<div class='message alert'>#{message}</div>")
      .fadeIn('slow').prependTo('body');

    window.setTimeout @hideMessage, 3000

  hideMessage: ->
    ($ '.message').fadeOut 'slow', ->
     ($ '.message').remove()

App.Utilities.MsgError = MsgError
