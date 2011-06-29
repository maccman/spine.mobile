manager = new Spine.Manager

class PanelManager extends Spine.Controller
  addPanel: (panels...) ->
    manager.add(panels...)
    @append(panels...)

module.exports = PanelManager