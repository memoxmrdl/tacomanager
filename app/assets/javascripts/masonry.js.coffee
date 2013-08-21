class Masonry
  constructor: (@selector, @item_selector, @width) ->
    $(@selector).masonry
      itemSelector: @item_selector
      columnWidth: @width

App.Utilities.Masonry = Masonry
