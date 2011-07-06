Panel   = require("lib/panel")
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
    
class Contacts extends Spine.Controller
  constructor: ->
    super
    
    @list = new ContactsList
    @item = new ContactsItem
    
    # Add to main stage
    @stage.add(@list, @item)

    @routes
      "/contacts": (params) -> 
        @list.active(params)
      "/contacts/:id": (params) ->
        @item.change Contact.find(params.id)
        @item.active(params)
        
module.exports = Contacts