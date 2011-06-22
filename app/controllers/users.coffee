Panel = require("controllers/panel")

module.exports = Panel.sub
  title: "Users"
  
  events: 
    "click .back": "back"

  init: ->
    backButton = $("<button />")
    backButton.text("Back").addClass("right back")
    @header.append(backButton)
    
  render: ->
    @content.html("")

  back: ->
    