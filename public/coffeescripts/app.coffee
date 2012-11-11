$ ->
  new bs.views.Recorder(el: '#recorder')
  recorder = new bs.views.Recorder(el: '#recorder')

  recorder.on "gif:create", (data) ->
    gif = new bs.models.Gif(encodedData: data)
    gif.save()
      .done(-> alert("Your gif was created successfully!"))
      .fail(-> alert("We had some trouble saving your gif."))

window.onload = ->
  $('#gifs').masonry
    itemSelector: 'li'
    columnWidth: 20

