class bs.views.Gif extends Backbone.View

  template: """
    <li>
      <a href="{{ link }}">
        <img src="{{ url }}" />
      </a>
    </li>
  """

  toHtml: ->
    Mustache.render @template, link: @model.link(), url: @model.get('url')
