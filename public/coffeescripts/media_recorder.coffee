window.URL ?= webkitURL
window.requestAnimationFrame ?= webkitRequestAnimationFrame || mozRequestAnimationFrame || msRequestAnimationFrame || oRequestAnimationFrame
window.cancelAnimationFrame ?= webkitCancelAnimationFrame || mozCancelAnimationFrame || msCancelAnimationFrame || oCancelAnimationFrame
navigator.getUserMedia ?= navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia


class window.MediaRecorder

  constructor: (opts) ->
    @video = opts.video
    @canvas = opts.canvas
    @height = opts.height
    @width = opts.width

    @canvas.height = @height
    @canvas.width = @width
    @ctx = @canvas.getContext('2d')

    @currentRafId = null
    @frames = []

    @_setupVideo()

  start: ->
    @encoder = new GIFEncoder()
    @encoder.setSize(@width, @height)
    @encoder.setRepeat(100000)
    @encoder.setQuality(20)
    @encoder.start()

    @currentRafId = requestAnimationFrame(@_drawVideoFrame)

  stop: ->
    cancelAnimationFrame(@currentRafId)
    @encoder.finish()

  dataURL: ->
    "data:image/gif;base64,#{ @_rawDataURL() }"

  _rawDataURL: ->
    $.base64.encode(@encoder.stream().getData())

  _drawVideoFrame: =>
    @currentRafId = requestAnimationFrame(@_drawVideoFrame)
    @ctx.drawImage(@video, 0, 0, @width, @height)
    @encoder.addFrame(@ctx)

  _setupVideo: =>
    navigator.getUserMedia { video: true }, (stream) =>
      @video.src = URL.createObjectURL(stream)
      @ctx.drawImage(@video, 0, 0, @canvas.width, @canvas.height)

