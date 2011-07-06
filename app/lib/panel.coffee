Stage = require("lib/stage")

class Panel extends Stage
  title: false

  constructor: ->
    super
    
    @el.addClass("panel")
    @header  = $("<header />")
    @header.append($("<h2 />").html(@title)) if @title
    @content = $("<div />").addClass("content")

    @append(@header, @content)

  html: -> @content.html.apply(@content, arguments)
  
  effects:
    left: ->
      @el.addClass("active")
      @content.gfxSlideIn(direction: "left")
      @header.gfxSlideIn(direction: "left", fade: true, distance: 50)
    
    right: ->
      @el.addClass("active")
      @content.gfxSlideIn(direction: "right")
      @header.gfxSlideIn(direction: "right", fade: true, distance: 50)
  
  reverseEffects:
    left: ->
      @content.gfxSlideOut(direction: "right")
      @header.gfxSlideOut(direction: "right", fade: true, distance: 50)
      @content.queueNext => @el.removeClass("active")
    
    right: ->
      @content.gfxSlideOut(direction: "left")
      @header.gfxSlideOut(direction: "left", fade: true, distance: 50)
      @content.queueNext => @el.removeClass("active")

module.exports = Panel