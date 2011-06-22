require("lib/gfx.ext")

Panel   = require("controllers/panel")
Manager = require("controllers/panel.manager")

module.exports = Spine.Controller.sub
  init: ->
    @users = Users.init()
    @place = Place.init()
    
    Manager.init()
      .addRow("country", "place", "venue")
      .addRow("profile")
    
$.preventDefaultTouch()