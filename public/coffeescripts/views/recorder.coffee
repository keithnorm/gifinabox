class bs.views.Recorder extends Backbone.View

  events:
    "click #record": "_record"
    "click #stop": "_stop"

  initialize: ->
    @$startButton = $('#record')
    @$stopButton = $('#stop')

    disable(@$stopButton)
    enable(@$startButton)

    @recorder = new MediaRecorder
      video: @$("video")[0]
      canvas: @$("canvas")[0]
      height: 240  # px
      width: 320  # px

  _record: ->
    disable(@$startButton)
    enable(@$stopButton)

    @recorder.start()

  _stop: ->
    disable(@$stopButton)
    enable(@$startButton)

    @recorder.stop()
    @$("#gif").attr('src', @recorder.dataURL())

  disable = ($el) ->
    $el.attr('disabled', 'disabled')

  enable = ($el) ->
    $el.removeAttr('disabled')
