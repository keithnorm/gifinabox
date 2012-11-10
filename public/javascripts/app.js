(function() {

  $(function() {
    var recorder;
    recorder = new MediaRecorder({
      video: $("video")[0],
      canvas: $("canvas")[0]
    });
    $("#record").click(function() {
      return recorder.start();
    });
    return $("#stop").click(function() {
      return recorder.stop();
    });
  });

}).call(this);
