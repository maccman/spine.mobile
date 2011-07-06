Stage = require("lib/stage")

class Main extends Stage
  elements: 
    "header":   "header"
    ".content": "content"
    "footer":   "footer"
    
  constructor: ->
    # A global stage
    @global = true
    super
  
  append: (elements...) ->
    elements = (e.el or e for e in elements)
    @content.append(elements...)
    
module.exports = Main