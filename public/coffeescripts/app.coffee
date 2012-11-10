$ ->

  getUserMedia = (args...) ->
    navigator.getUserMedia?(args...) || navigator.webkitGetUserMedia?(args...)

  userMedia = getUserMedia { video: true },
    (stream) -> $('video').attr('src', URL.createObjectURL(stream)),
    (error) -> alert("Had some trouble!")
