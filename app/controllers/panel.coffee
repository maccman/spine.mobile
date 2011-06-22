module.exports = Panel = Spine.Controller.sub
  title: "Panel Title"
  header: true
  footer: true

  initialize: ->
    super
    @header  = $("<header />").attr("id", "header")
    @header.append($("<h1 />").html(@title))
    @content = $("<div />").attr("id", "content")
    @footer  = $("<footer />").attr("id", "footer")
    @el.append(@header) if @header
    @el.append(@content)
    @el.append(@footer) if @footer
    
  render: ->
    
  activate: (effect) ->
    @effects[effect].apply(this) if effect
    
  deactivate: (effect) ->
    @reverseEffects[effect].apply(this) if effect

  effects:
    left: ->
      @content.gfxSlideIn(direction: "left")
      @header.gfxSlideIn(direction: "left", fade: true)
    
    right: ->
      @content.gfxSlideIn(direction: "right")
      @header.gfxSlideIn(direction: "right", fade: true)
  
  reverseEffects:
    left: ->
      @content.gfxSlideOut(direction: "right")
      @header.gfxSlideOut(direction: "right", fade: true)
    
    right: ->
      @content.gfxSlideOut(direction: "left")
      @header.gfxSlideOut(direction: "left", fade: true)