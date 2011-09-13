Spine = require('spine')

globalManager = new Spine.Manager

class Stage extends Spine.Controller
  @globalManager: -> globalManager
  @globalStage:   -> @globalManager().controllers[0]
  
  constructor: ->
    super
    @el.addClass('stage viewport')
    globalManager.add(@) if @global

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
      @el.gfxSlideIn(direction: 'left', duration: 300)
    
    right: ->
      @el.addClass('active')
      @el.gfxSlideIn(direction: 'right', duration: 300)
  
  reverseEffects:
    left: ->
      @el.gfxSlideOut(direction: 'right')
      @el.queueNext => @el.removeClass('active', duration: 300)
    
    right: ->
      @el.gfxSlideOut(direction: 'left')
      @el.queueNext => @el.removeClass('active', duration: 300)
      
class Stage.Global extends Stage
  global: true

module.exports = Stage