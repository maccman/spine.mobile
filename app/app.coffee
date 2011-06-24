Contacts = require("controllers/contacts")
Contact  = require("models/contact")

class App extends Spine.Controller
  elements:
    "#panels": "panels"

  constructor: ->
    super
    
    @contacts = new Contacts(el: @panels)
    
    Spine.preventDefaultTouch()
    Spine.Route.setup(shim: true)
    
    Contact.create(name: "Alex MacCaw")
    Contact.create(name: "Richard MacCaw")
    
module.exports = App