Spine = require('spine')
$     = Spine.$

globalManager = new Spine.Manager

class Stage extends Spine.Controller
  @globalManager: -> globalManager
  @globalStage:   -> @globalManager().controllers[0]
  
  effectDefaults:
    duration: 450
    easing: 'cubic-bezier(.25, .1, .25, 1)'
    
  effectOptions: (options = {})  ->
    $.extend({}, @effectDefaults, options)

  viewport: true
  
  constructor: ->
    super
    @el.addClass('stage')
    
    @header  = $('<header />')
    @content = $('<article />')
    @footer  = $('<footer />')
    
    @content.addClass('viewport') if @viewport
    
    @el.append(@header, @content, @footer)
    globalManager.add(@) if @global
    
  append: (elements...) -> 
    elements = (e.el or e for e in elements)
    @content.append(elements...)

  html: -> 
    @content.html.apply(@content, arguments)
    @refreshElements()
    @content

  add: (panels...) ->
    @manager or= new Spine.Manager
    @manager.add(panels...)
    @append(panels...)

  activate: (params = {}) ->
    effect = params.transition or params.trans
    if effect
      @effects[effect].apply(this)
    else
      @el.addClass('active')

  deactivate: (params = {}) ->
    return unless @isActive()
    effect = params.transition or params.trans
    if effect
      @reverseEffects[effect].apply(this)
    else
      @el.removeClass('active')
    
  isActive: ->
    @el.hasClass('active')

  effects:
    left: ->
      @el.addClass('active')
      @el.gfxSlideIn(@effectOptions(direction: 'left'))
    
    right: ->
      @el.addClass('active')
      @el.gfxSlideIn(@effectOptions(direction: 'right'))
  
  reverseEffects:
    left: ->
      @el.gfxSlideOut(@effectOptions(direction: 'right'))
      @el.queueNext => @el.removeClass('active')
    
    right: ->
      @el.gfxSlideOut(@effectOptions(direction: 'left'))
      @el.queueNext => @el.removeClass('active')
      
class Stage.Global extends Stage
  global: true

(module?.exports = Stage) or @Stage = Stage