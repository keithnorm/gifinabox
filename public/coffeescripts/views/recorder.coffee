class bs.views.Recorder extends Backbone.View

  events:
    "click #record:not(.stop)": "_record"
    "click #record.stop": "_stop"

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
    disable(@$startButton)
    @$("video").show()
    @$("#gif").hide()

    @recorder.start()

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

  onSave = (link) ->
    $('#link').attr('href', link).text(link)
    $('#record').removeClass 'uploading'
    alert("Your gif was created successfully!")

  onError = ->
    alert("We had some trouble saving your gif.")
