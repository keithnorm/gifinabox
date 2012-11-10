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
    console.log("#record")
    @currentRafId = requestAnimationFrame(@_drawVideoFrame)

    @encoder = new GIFEncoder()
    @encoder.setSize(@width, @height)
    @encoder.setRepeat(100000)
    @encoder.setQuality(20)
    @encoder.start()

  stop: ->
    console.log("#stop", @frames)
    cancelAnimationFrame(@currentRafId)
    @encoder.finish()

  dataURL: ->
    "data:image/gif;base64,#{ @_rawDataURL() }"

  _rawDataURL: ->
    $.base64.encode(@encoder.stream().getData())

  _drawVideoFrame: =>
    @currentRafId = requestAnimationFrame(@_drawVideoFrame)
    @ctx.drawImage(@video, 0, 0, @width, @height)

    console.log "adding frame"
    @encoder.addFrame(@ctx)

    @frames.push(@canvas.toDataURL('image/png', 1))

  _setupVideo: =>
    console.log("#_setupVideo")

    navigator.getUserMedia { video: true }, (stream) =>
      @video.src = URL.createObjectURL(stream)
      @ctx.drawImage(@video, 0, 0, @canvas.width, @canvas.height)

