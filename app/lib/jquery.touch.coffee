$ = jQuery

$.support.touch = ('ontouchstart' of window)

$.preventDefaultTouch = ->
  $('body').bind 'touchmove', (e) -> e.preventDefault()

$.setupTouch = ->
  touch = {}
  
  parentIfText = (node) ->
    if 'tagName' of node then node else node.parentNode
  
  $('body').bind 'touchstart', (e) ->
    e = e.originalEvent
    now = Date.now()
    touch.target = parentIfText(e.touches[0].target)
    touch.x1 = e.touches[0].pageX
    touch.y1 = e.touches[0].pageY
    touch.last = now
  .bind 'touchmove', (e) ->
    e = e.originalEvent
    touch.x2 = e.touches[0].pageX
    touch.y2 = e.touches[0].pageY
  .bind 'touchend', ->
    if 'last' of touch
      $(touch.target).trigger('tap')
      touch = {}
  .bind 'touchcancel', ->
    touch = {}  

unless $.support.touch
  $.setupTouch = ->
    $('body').bind 'click', (e) -> $(e.target).trigger('tap')

types = ['swipe', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown', 'doubleTap', 'tap']
($.fn[type] = (callback) -> @bind(type, callback)) for type in types