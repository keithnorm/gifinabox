(function() {

  $(function() {
    var recorder;
    recorder = new MediaRecorder({
      video: $("video")[0],
      canvas: $("canvas")[0],
      height: 240,
      width: 320
    });
    $("#record").click(function() {
      return recorder.start();
    });
    return $("#stop").click(function() {
      recorder.stop();
      return $("#gif").attr('src', recorder.dataURL());
    });
  });

}).call(this);
