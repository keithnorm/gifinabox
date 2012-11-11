$ ->
  new bs.views.Recorder(el: '#recorder')

window.onload = ->
  $('#gifs').masonry
    itemSelector: 'li'
    columnWidth: 20

