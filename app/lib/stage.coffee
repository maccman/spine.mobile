globalManager = new Spine.Manager

class Stage extends Spine.Controller
  @globalManager: -> globalManager
  @globalStage: -> @globalManager().controllers[0]
  
  constructor: ->
    super
    @el.addClass("stage")
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
      @el.addClass("active")

  deactivate: (params = {}) ->
    effect = params.transition or params.trans
    return unless @isActive()
    if effect
      @reverseEffects[effect].apply(this)
    else
      @el.removeClass("active")
    
  isActive: ->
    @el.hasClass("active")

  effects:
    left: ->
      @el.addClass("active")
      @el.gfxSlideIn(direction: "left")
    
    right: ->
      @el.addClass("active")
      @el.gfxSlideIn(direction: "right")
  
  reverseEffects:
    left: ->
      @el.gfxSlideOut(direction: "right")
      @el.queueNext => @el.removeClass("active")
    
    right: ->
      @el.gfxSlideOut(direction: "left")
      @el.queueNext => @el.removeClass("active")

module.exports = Stage