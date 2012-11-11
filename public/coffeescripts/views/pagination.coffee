class bs.views.Pagination extends Backbone.View

  template: """
    <button href="#" class="next">Next Page</button>
  """

  events:
    'click .next': 'next'

  initialize: ->
    @on "pagination:empty", =>
      @$el.html """
        <p class='message'>You've seen all the gifs! <a href='/'>Go make some more.</a></p>
      """

  render: ->
    @$el.append(@template)

  next: (e) ->
    e.preventDefault()
    @trigger 'click:next'