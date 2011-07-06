require("lib/jquery.touch")

Stage    = require("controllers/index")
Contacts = require("controllers/contacts")
Contact  = require("models/contact")

class App extends Spine.Controller
  elements:
    "#stage": "stage"

  constructor: ->
    super
    
    @stage    = new Stage(el: @stage)
    @contacts = new Contacts(stage: @stage)
    
    $.preventDefaultTouch()
    $.setupTouch()
    Spine.Route.setup(shim: true)
    
    @navigate "/contacts"
    
    Contact.create(name: "Alex MacCaw", email: "info@eribium.org")
    Contact.create(name: "Richard MacCaw", email: "ricci@example.com")
    
module.exports = App