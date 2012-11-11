$ ->
  recorder = new bs.views.Recorder(el: '#recorder')

  recorder.on "gif:create", (data) ->
    gif = new bs.models.Gif(encodedData: data)
    gif.save()
      .done(-> recorder.trigger('gif:done', gif.link()))
      .fail(-> recorder.trigger('gif:fail'))

window.onload = ->
  $('#gifs').masonry
    itemSelector: 'li'
    columnWidth: 20

