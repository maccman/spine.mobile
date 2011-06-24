Panel   = require("lib/panel")
Contact = require("models/contact")

ContactsList = Panel.sub
  title: "Contacts"
  events:
    "click .item": "click"

  proxied: ["render"]

  init: ->
    Contact.bind("change refresh", @render)
  
  render: ->
    contacts = Contact.all()
    @html require("views/contacts/list")(contacts)
    
  click: (e) ->
    item = $(e.target).item()
    @navigate("/contacts", item.id, trans: "right")

ContactsItem = Panel.sub
  title: "Contact"
  events:
    "click .back": "back"

  init: ->
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
    
module.exports = Contacts = Spine.Controller.sub
  init: ->
    @list = ContactsList.init()
    @item = ContactsItem.init()
    Spine.Manager.init(@list, @list)
    
    @append(@list, @item)
    
    @routes
      "/contacts": (params) -> 
        @list.active(params)
      "/contacts/:id": (params) ->
        @item.change Contact.find(params.id)
        @item.active(params)