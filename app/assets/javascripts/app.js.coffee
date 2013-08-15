window.App = {
  Utilities: {}
}

initContent = ->
  HideMessage = new App.Utilities.HideMessages()

$(document).ready initContent
$(document).on "page:load", initContent
