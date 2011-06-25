Contacts = require("controllers/contacts")
Contact  = require("models/contact")

class App extends Spine.Controller
  elements:
    "#content": "content"

  constructor: ->
    super
    
    @contacts = new Contacts(el: @content)
    
    Spine.preventDefaultTouch()
    Spine.Route.setup(shim: true)
    
    Contact.create(name: "Alex MacCaw")
    Contact.create(name: "Richard MacCaw")
    
module.exports = App