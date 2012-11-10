(function() {
  var __slice = Array.prototype.slice;

  $(function() {
    var getUserMedia, userMedia;
    getUserMedia = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return (typeof navigator.getUserMedia === "function" ? navigator.getUserMedia.apply(navigator, args) : void 0) || (typeof navigator.webkitGetUserMedia === "function" ? navigator.webkitGetUserMedia.apply(navigator, args) : void 0);
    };
    return userMedia = getUserMedia({
      video: true
    }, function(stream) {
      return $('video').attr('src', URL.createObjectURL(stream));
    }, function(error) {
      return alert("Had some trouble!");
    });
  });

}).call(this);
