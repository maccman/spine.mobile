Panel   = require("lib/panel")
Contact = require("models/contact")

class ContactsList extends Panel
  title: "Contacts"
  events:
    "click .item": "click"

  constructor: ->
    super
    Contact.bind("change refresh", @render)
  
  render: =>
    contacts = Contact.all()
    @html require("views/contacts/list")(contacts)
    
  click: (e) ->
    item = $(e.target).item()
    @navigate("/contacts", item.id, trans: "right")

class ContactsItem extends Panel
  title: "Contact"
  events:
    "click .back": "back"

  constructor: ->
    super
    backButton = $("<button />")
    backButton.text("Back").addClass("right back")
    @header.append(backButton)

  back: ->
    @navigate("/contacts", trans: "left")
    
  render: ->
    @html require("views/contacts/show")(@item)
    
  change: (item) ->
    @item = item
    @render()
    
class Contacts extends Spine.Controller
  constructor: ->
    super
    
    @list = new ContactsList
    @item = new ContactsItem
    
    new Spine.Manager(@list, @item)
    
    @append(@list, @item)

    @routes
      "/contacts": (params) -> 
        @list.active(params)
      "/contacts/:id": (params) ->
        @item.change Contact.find(params.id)
        @item.active(params)
        
    @list.active()
        
module.exports = Contacts