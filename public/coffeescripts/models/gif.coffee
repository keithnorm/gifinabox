class bs.models.Gif extends Backbone.Model

  urlRoot: "/gifs"

  link: =>
    "#{ window.location.host }#{ @urlRoot }/#{ @get('slug') }"
