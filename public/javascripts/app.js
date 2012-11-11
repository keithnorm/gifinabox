// Generated by CoffeeScript 1.4.0
(function() {

  $(function() {
    var recorder;
    recorder = new bs.views.Recorder({
      el: '#recorder'
    });
    return recorder.on("gif:create", function(data) {
      var gif;
      gif = new bs.models.Gif({
        encodedData: data
      });
      return gif.save().done(function() {
        return this.recorder.trigger('gif:done', gif.link());
      }).fail(function() {
        return this.recorder.trigger('gif:fail');
      });
    });
  });

  window.onload = function() {
    return $('#gifs').masonry({
      itemSelector: 'li',
      columnWidth: 20
    });
  };

}).call(this);
