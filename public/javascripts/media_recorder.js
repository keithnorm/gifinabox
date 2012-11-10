(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (window.URL == null) window.URL = webkitURL;

  if (window.requestAnimationFrame == null) {
    window.requestAnimationFrame = webkitRequestAnimationFrame || mozRequestAnimationFrame || msRequestAnimationFrame || oRequestAnimationFrame;
  }

  if (window.cancelAnimationFrame == null) {
    window.cancelAnimationFrame = webkitCancelAnimationFrame || mozCancelAnimationFrame || msCancelAnimationFrame || oCancelAnimationFrame;
  }

  if (navigator.getUserMedia == null) {
    navigator.getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
  }

  window.MediaRecorder = (function() {

    function MediaRecorder(opts) {
      this._setupVideo = __bind(this._setupVideo, this);
      this._drawVideoFrame = __bind(this._drawVideoFrame, this);      this.video = opts.video;
      this.canvas = opts.canvas;
      this.ctx = this.canvas.getContext('2d');
      this.CANVAS_WIDTH = this.canvas.width;
      this.CANVAS_HEIGHT = this.canvas.height;
      this.currentRafId = null;
      this.frames = [];
      this._setupVideo();
    }

    MediaRecorder.prototype.start = function() {
      console.log("#record");
      return this.currentRafId = requestAnimationFrame(this._drawVideoFrame);
    };

    MediaRecorder.prototype.stop = function() {
      console.log("#stop", this.frames);
      return cancelAnimationFrame(this.currentRafId);
    };

    MediaRecorder.prototype._drawVideoFrame = function() {
      this.currentRafId = requestAnimationFrame(this._drawVideoFrame);
      this.ctx.drawImage(this.video, 0, 0, this.CANVAS_WIDTH, this.CANVAS_HEIGHT);
      return this.frames.push(this.canvas.toDataURL('image/png', 1));
    };

    MediaRecorder.prototype._setupVideo = function() {
      var _this = this;
      console.log("#_setupVideo");
      return navigator.getUserMedia({
        video: true
      }, function(stream) {
        _this.video.src = URL.createObjectURL(stream);
        return _this.ctx.drawImage(_this.video, 0, 0, _this.canvas.width, _this.canvas.height);
      });
    };

    return MediaRecorder;

  })();

}).call(this);
