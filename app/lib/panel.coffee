module.exports = Panel = Spine.Controller.sub
  title: "Panel Title"
  hasHeader: true
  hasFooter: true

  initialize: ->
    console.log(@constructor)
    # @constructor.initialize.apply(@)
    @el.addClass("panel")
    @header  = $("<header />")
    @header.append($("<h2 />").html(@title))
    @content = $("<div />")
    @footer  = $("<footer />")
    @append(@header) if @hasHeader
    @append(@content)
    @append(@footer) if @hasFooter

  html: -> @content.apply(@content, arguments)
    
  activate: (params) ->
    effect = params.transition or params.trans
    @effects[effect].apply(this) if effect
    
  deactivate: (params) ->
    effect = params.transition or params.trans
    @reverseEffects[effect].apply(this) if effect and @isActive()

  effects:
    left: ->
      @content.gfxSlideIn(direction: "left")
      @header.gfxSlideIn(direction: "left", fade: true)
      @content.queueNext ->
        @el.addClass("active")
    
    right: ->
      @content.gfxSlideIn(direction: "right")
      @header.gfxSlideIn(direction: "right", fade: true)
      @content.queueNext ->
        @el.addClass("active")
  
  reverseEffects:
    left: ->
      @content.gfxSlideOut(direction: "right")
      @header.gfxSlideOut(direction: "right", fade: true)
      @content.queueNext ->
        @el.removeClass("active")
    
    right: ->
      @content.gfxSlideOut(direction: "left")
      @header.gfxSlideOut(direction: "left", fade: true)
      @content.queueNext ->
        @el.removeClass("active")