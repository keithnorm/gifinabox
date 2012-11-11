class bs.views.Pagination extends Backbone.View

  template: """
    <button href="#" class="next">Next Page</button>
  """

  events:
    'click .next': 'next'

  render: ->
    @$el.append(@template)

  next: (e) ->
    e.preventDefault()
    @trigger 'click:next'