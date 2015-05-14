# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Auto hide menu when option is selected
$('.nav-collapse-menu').click 'li', ->
  $('.nav-collapse-menu').collapse 'hide'
    return
