$ = jQuery

$.fn.gfxSlideOut = (options = {}) ->
  options.direction or= 'right'
  
  distance = 100
  distance *= -1 if options.direction = 'left'
  distance += "%"
  
  opacity = if options.fade then 0 else 1
  
  $(@).gfx({translateX: distance, opacity: opacity}, options)
  $(@).queueNext ->
    $(@).transform(translateX: 0, opacity: 1, display: 'none')
    
$.fn.gfxSlideIn = (options = {}) ->
  options.direction or= 'right'

  distance = 100
  distance *= -1 if options.direction = 'left'
  distance += "%"

  opacity = if options.fade then 0 else 1

  $(@).queueNext ->
    $(@).transform(translateX: distance, opacity: opacity, display: 'none')
  $(@).gfx({translateX: 0, opacity: 1}, options)
