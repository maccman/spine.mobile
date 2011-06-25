require("lib/jquery.touch")
Contacts = require("controllers/contacts")
Contact  = require("models/contact")

class App extends Spine.Controller
  elements:
    "#content": "content"

  constructor: ->
    super
    
    @contacts = new Contacts(el: @content)
    
    $.preventDefaultTouch()
    $.setupTouch()
    Spine.Route.setup(shim: true)
    
    Contact.create(name: "Alex MacCaw", email: "info@eribium.org")
    Contact.create(name: "Richard MacCaw", email: "ricci@example.com")
    
module.exports = App