Panel   = require("lib/panel")
Manager = require("lib/panel.manager")
Contact = require("models/contact")

class ContactsList extends Panel
  title: "Contacts"
  events:
    "tap .item": "click"

  constructor: ->
    super
    @content.addClass("list")
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
    "tap .back": "back"

  constructor: ->
    super
    backButton = $("<button />")
    backButton.text("Back").addClass("left back")
    @header.append(backButton)
    @content.addClass("fillout")

  back: ->
    @navigate("/contacts", trans: "left")
    
  render: ->
    @html require("views/contacts/show")(@item)
    
  change: (item) ->
    @item = item
    @render()
    
class Contacts extends Manager
  constructor: ->
    super
    
    @list = new ContactsList
    @item = new ContactsItem
    
    @addPanel(@list, @item)

    @routes
      "/contacts": (params) -> 
        @list.active(params)
      "/contacts/:id": (params) ->
        @item.change Contact.find(params.id)
        @item.active(params)
        
module.exports = Contacts