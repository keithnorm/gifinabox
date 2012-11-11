class bs.views.Gifs extends Backbone.View

  initialize: (@options) ->
    @$el.html('')

    @models = @options.models
    @render()

  render: ->
    for model in @models
      view = new bs.views.Gif({ model: model })
      @$el.append view.toHtml()