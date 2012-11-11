class bs.models.Gif extends Backbone.Model

  urlRoot: "/gifs"

  link: =>
    "#{ window.location.protocol }//#{ window.location.host }#{ @urlRoot }/#{ @get('slug') }"
