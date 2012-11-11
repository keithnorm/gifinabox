class bs.views.Pagination extends Backbone.View

  template: """
    <ul>
      <li><a href="#" class="prev">prev</a>
      <li><a href="#" class="next">next</a>
    </ul>
  """

  events:
    'click .prev': 'prev'
    'click .next': 'next'

  render: ->
    @$el.append(@template)

  prev: (e) ->
    e.preventDefault()
    @trigger 'click:prev'

  next: (e) ->
    e.preventDefault()
    @trigger 'click:next'