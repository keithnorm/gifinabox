window.URL ?= webkitURL
window.requestAnimationFrame ?= webkitRequestAnimationFrame || mozRequestAnimationFrame || msRequestAnimationFrame || oRequestAnimationFrame
window.cancelAnimationFrame ?= webkitCancelAnimationFrame || mozCancelAnimationFrame || msCancelAnimationFrame || oCancelAnimationFrame
navigator.getUserMedia ?= navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia


class window.MediaRecorder

  constructor: (opts) ->
    @video = opts.video
    @canvas = opts.canvas
    @ctx = @canvas.getContext('2d')

    @CANVAS_WIDTH = @canvas.width
    @CANVAS_HEIGHT = @canvas.height

    @currentRafId = null
    @frames = []

    @_setupVideo()

  start: ->
    console.log("#record")
    @currentRafId = requestAnimationFrame(@_drawVideoFrame)

  stop: ->
    console.log("#stop", @frames)
    cancelAnimationFrame(@currentRafId)

  _drawVideoFrame: =>
    @currentRafId = requestAnimationFrame(@_drawVideoFrame)
    @ctx.drawImage(@video, 0, 0, @CANVAS_WIDTH, @CANVAS_HEIGHT)
    @frames.push(@canvas.toDataURL('image/png', 1))

  _setupVideo: =>
    console.log("#_setupVideo")

    navigator.getUserMedia { video: true }, (stream) =>
      @video.src = URL.createObjectURL(stream)
      @ctx.drawImage(@video, 0, 0, @canvas.width, @canvas.height)

