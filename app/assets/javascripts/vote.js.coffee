class Vote
  constructor: ->
    $('#good').on 'click', (e) ->
      est_id = $(@).attr('data-establishment-id')
      $.post "/dashboard/establishments/#{est_id}/vote",
        { vote: { vote_good: true } }
      e.stopImmediatePropagation()

    $('#bad').on 'click', (e) ->
      est_id = $(@).attr('data-establishment-id')
      $.post "/dashboard/establishments/#{est_id}/vote",
        { vote: { vote_bad: true } }
      e.stopImmediatePropagation()

App.Utilities.Vote = Vote
