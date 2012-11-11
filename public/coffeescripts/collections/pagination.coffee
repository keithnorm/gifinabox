class bs.collections.Pagination extends Backbone.Collection

  GIFS_PER_PAGE: 18

  urlRoot: '/p'

  initialize: (@options={}) ->
    @gifsCollection = @options.gifsCollection

    @view = new bs.views.Pagination el: "#pagination"
    @view.render()

    @currentOffset = +(@options.offset ? 0)

    @view.on 'click:next', @_fetchNext


  parse: (response) ->
    @gifsCollection.reset(response.gifs)
    @currentOffset = response.offset

  _fetchNext: =>
    params =
      offset: @currentOffset + @GIFS_PER_PAGE

    @url = @_contructUrl(params)

    @fetch()

  _contructUrl: (params) =>
    "#{ @urlRoot }?#{ $.param(params) }"