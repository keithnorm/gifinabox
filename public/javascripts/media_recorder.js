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
      this.height = opts.height;
      this.width = opts.width;
      this.canvas.height = this.height;
      this.canvas.width = this.width;
      this.ctx = this.canvas.getContext('2d');
      this.currentRafId = null;
      this.frames = [];
      this._setupVideo();
    }

    MediaRecorder.prototype.start = function() {
      this.encoder = new GIFEncoder();
      this.encoder.setSize(this.width, this.height);
      this.encoder.setRepeat(100000);
      this.encoder.setQuality(20);
      this.encoder.start();
      return this.currentRafId = requestAnimationFrame(this._drawVideoFrame);
    };

    MediaRecorder.prototype.stop = function() {
      cancelAnimationFrame(this.currentRafId);
      return this.encoder.finish();
    };

    MediaRecorder.prototype.dataURL = function() {
      return "data:image/gif;base64," + (this._rawDataURL());
    };

    MediaRecorder.prototype._rawDataURL = function() {
      return $.base64.encode(this.encoder.stream().getData());
    };

    MediaRecorder.prototype._drawVideoFrame = function() {
      this.currentRafId = requestAnimationFrame(this._drawVideoFrame);
      this.ctx.drawImage(this.video, 0, 0, this.width, this.height);
      return this.encoder.addFrame(this.ctx);
    };

    MediaRecorder.prototype._setupVideo = function() {
      var _this = this;
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
