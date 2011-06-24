require("lib/gfx.ext")

Contacts = require("controllers/contacts")

module.exports = Spine.Controller.sub
  elements:
    "#panels": "panels"

  init: ->
    Contacts.init(el: @panels)
    
    Spine.preventDefaultTouch()
    Spine.Route.setup(shim: true)