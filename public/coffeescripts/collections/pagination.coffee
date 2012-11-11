class bs.collections.Pagination extends Backbone.Collection

  GIFS_PER_PAGE: 18

  urlRoot: '/p'

  initialize: (@options={}) ->
    @gifsCollection = @options.gifsCollection

    @view = new bs.views.Pagination el: "#pagination"
    @view.render()

    @view.on 'click:next', @_fetchNext

    @gifsCollection.on "reset", =>
      if @gifsCollection.isEmpty()
        @view.trigger("pagination:empty")

  parse: (response) ->
    return if _.isEmpty(response.gifs)

    @gifsCollection.reset(response.gifs)

    @count = response.count
    @currentOffset = response.offset

  _fetchNext: =>
    return if @currentOffset >= @count

    params =
      offset: @currentOffset ?= @GIFS_PER_PAGE

    @url = @_contructUrl(params)

    @fetch()

  _contructUrl: (params) =>
    "#{ @urlRoot }?#{ $.param(params) }"