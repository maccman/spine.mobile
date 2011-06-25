class Panel extends Spine.Controller
  title: "Panel Title"

  constructor: ->
    super
    @el.addClass("panel")
    @header  = $("<header />")
    @header.append($("<h2 />").html(@title))
    @content = $("<div />").addClass("content")
    @append(@header)
    @append(@content)

  html: -> @content.html.apply(@content, arguments)
    
  activate: (params = {}) ->
    effect = params.transition or params.trans
    @el.addClass("active")
    @effects[effect].apply(this) if effect

  deactivate: (params = {}) ->
    effect = params.transition or params.trans
    
    if effect
      @reverseEffects[effect].apply(this) if @isActive()
      @content.queueNext =>
        @el.removeClass("active")
    else
      @el.removeClass("active")

  effects:
    left: ->
      @content.gfxSlideIn(direction: "left")
      @header.gfxSlideIn(direction: "left", fade: true, distance: 50)
    
    right: ->
      @content.gfxSlideIn(direction: "right")
      @header.gfxSlideIn(direction: "right", fade: true, distance: 50)
  
  reverseEffects:
    left: ->
      @content.gfxSlideOut(direction: "right")
      @header.gfxSlideOut(direction: "right", fade: true, distance: 50)
    
    right: ->
      @content.gfxSlideOut(direction: "left")
      @header.gfxSlideOut(direction: "left", fade: true, distance: 50)

module.exports = Panel