class bs.views.Recorder extends Backbone.View

  RECORD_TIME = 5000  # ms

  events:
    "click #record:not(.stop)": "_record"

  initialize: ->
    @$startButton = $('#record')
    enable(@$startButton)

    @on 'gif:uploading', this._uploadStart.bind(this)
    @on 'gif:done', onSave
    @on 'gif:fail', onError

    @recorder = new MediaRecorder
      video: @$("video")[0]
      canvas: @$("canvas")[0]
      height: 240  # px
      width: 320  # px

  _record: ->
    @$("video").hide()
    @$('#intro').show().attr('src', '/images/intro.gif?' + (new Date()).getTime())
    @$('.instructions').css 'visibility', 'hidden'

    # this starts the film intro animation
    setTimeout =>
      disable(@$startButton)
      @$('#intro').hide()
      @$("video").show()
      @$("#gif").hide()
      @recorder.start()
      
      countDown RECORD_TIME,
        tick: (tick) => @$startButton.text(tick)
        done: => @_stop()
    , 2000

  _stop: ->
    enable(@$startButton)

    @recorder.stop()

    @$("#gif").attr('src', "data:image/gif;base64,#{ @recorder.encodedData() }").show()
    @$("video").hide()
    @trigger("gif:create", @recorder.encodedData())

  _uploadStart: (e) ->
    @$startButton.attr 'class', 'uploading'

  disable = ($el) ->
    $el.attr('class', 'stop')

  enable = ($el) ->
    $el.removeClass('stop').removeClass('uploading')

  onSave = (gif) ->
    $('#link').attr('href', gif.link()).text(gif.link())
    $('#gifs').prepend "<li><a href='#{ gif.link() }'><img src='#{ gif.get('url') }'></a></li>"
    $('#record').removeClass 'uploading'

  onError = ->
    alert("We had some trouble saving your gif.")

  countDown = (ms, opts) ->
    numberOfTicks = ms / 1000
    timer = ->
      if numberOfTicks > 0
        opts.tick(numberOfTicks)
        numberOfTicks -= 1
      else
        clearInterval(counter)
        opts.done()

    timer()
    counter = setInterval(timer, 1000)
