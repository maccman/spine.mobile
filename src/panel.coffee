$     = Spine.$
Gfx   = require('gfx')
Stage = require('./stage')

merge = (options, defaults) -> 
  $.extend({}, defaults, options)

class Panel extends Stage
  title: false
  
  effectDefaults:
    duration: 450
    easing: 'cubic-bezier(.25, .1, .25, 1)'

  constructor: ->
    super
    
    @el.addClass('panel').removeClass('viewport stage')
    @header  = $('<header />').addClass('panelHeader')
    @header.append($('<h2 />').html(@title)) if @title
    @content = $('<div />').addClass('content')

    @append(@header, @content)
    
    @stage ?= Stage.globalStage()
    @stage?.add(@)
    
  addButton: (text, callback) ->
    callback = @[callback] if typeof callback is 'string'
    button = $('<button />').text(text)
    button.tap(@proxy(callback))
    @header.append(button)
    button

  html: -> 
    @content.html.apply(@content, arguments)
    @refreshElements()
    @content
  
  activate: (params = {}) ->
    effect = params.transition or params.trans
    if effect
      @effects[effect].apply(this)
    else
      @content.add(@header).show()
      @el.addClass('active')

  deactivate: (params = {}) ->
    return unless @isActive()
    effect = params.transition or params.trans
    if effect
      @reverseEffects[effect].apply(this)
    else
      @el.removeClass('active')
  
  effects:
    left: ->
      @el.addClass('active')
      @content.gfxSlideIn(merge(direction: 'left', @effectDefaults))
      @header.gfxSlideIn(merge(direction: 'left', fade: true, distance: 50, @effectDefaults))
    
    right: ->
      @el.addClass('active')
      @content.gfxSlideIn(merge(direction: 'right', @effectDefaults))
      @header.gfxSlideIn(merge(direction: 'right', fade: true, distance: 50, @effectDefaults))
  
  reverseEffects:
    left: ->
      @content.gfxSlideOut(merge(direction: 'right', @effectDefaults))
      @header.gfxSlideOut(merge(direction: 'right', fade: true, distance: 50, @effectDefaults))
      @content.queueNext => 
        @el.removeClass('active')
    
    right: ->
      @content.gfxSlideOut(merge(direction: 'left', @effectDefaults))
      @header.gfxSlideOut(merge(direction: 'left', fade: true, distance: 50, @effectDefaults))
      @content.queueNext => 
        @el.removeClass('active')
        
module.exports = Panel