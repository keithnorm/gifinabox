$ ->
  recorder = new MediaRecorder
    video: $("video")[0]
    canvas: $("canvas")[0]

  $("#record").click -> recorder.start()
  $("#stop").click -> recorder.stop()
