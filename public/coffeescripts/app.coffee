$ ->
  recorder = new bs.views.Recorder(el: '#recorder')

  recorder.on "gif:create", (data) ->
    gif = new bs.models.Gif(encodedData: data)
    recorder.trigger('gif:uploading')
    gif.save()
      .done(-> recorder.trigger('gif:done', gif))
      .fail(-> recorder.trigger('gif:fail'))
