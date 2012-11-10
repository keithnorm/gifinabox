$ ->
  recorder = new MediaRecorder
    video: $("video")[0]
    canvas: $("canvas")[0]
    height: 240  # px
    width: 320  # px

  $("#record").click -> recorder.start()
  $("#stop").click ->
    recorder.stop()
    $("#gif").attr('src', recorder.dataURL())
