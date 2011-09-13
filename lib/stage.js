(function() {
  var Spine, Stage, globalManager;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __slice = Array.prototype.slice, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Spine = require('spine');
  globalManager = new Spine.Manager;
  Stage = (function() {
    __extends(Stage, Spine.Controller);
    Stage.globalManager = function() {
      return globalManager;
    };
    Stage.globalStage = function() {
      return this.globalManager().controllers[0];
    };
    function Stage() {
      Stage.__super__.constructor.apply(this, arguments);
      this.el.addClass('stage viewport');
      if (this.global) {
        globalManager.add(this);
      }
    }
    Stage.prototype.add = function() {
      var panels, _ref;
      panels = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.manager || (this.manager = new Spine.Manager);
      (_ref = this.manager).add.apply(_ref, panels);
      return this.append.apply(this, panels);
    };
    Stage.prototype.activate = function(params) {
      var effect;
      if (params == null) {
        params = {};
      }
      effect = params.transition || params.trans;
      if (effect) {
        return this.effects[effect].apply(this);
      } else {
        return this.el.addClass('active');
      }
    };
    Stage.prototype.deactivate = function(params) {
      var effect;
      if (params == null) {
        params = {};
      }
      if (!this.isActive()) {
        return;
      }
      effect = params.transition || params.trans;
      if (effect) {
        return this.reverseEffects[effect].apply(this);
      } else {
        return this.el.removeClass('active');
      }
    };
    Stage.prototype.isActive = function() {
      return this.el.hasClass('active');
    };
    Stage.prototype.effects = {
      left: function() {
        this.el.addClass('active');
        return this.el.gfxSlideIn({
          direction: 'left',
          duration: 300
        });
      },
      right: function() {
        this.el.addClass('active');
        return this.el.gfxSlideIn({
          direction: 'right',
          duration: 300
        });
      }
    };
    Stage.prototype.reverseEffects = {
      left: function() {
        this.el.gfxSlideOut({
          direction: 'right'
        });
        return this.el.queueNext(__bind(function() {
          return this.el.removeClass('active', {
            duration: 300
          });
        }, this));
      },
      right: function() {
        this.el.gfxSlideOut({
          direction: 'left'
        });
        return this.el.queueNext(__bind(function() {
          return this.el.removeClass('active', {
            duration: 300
          });
        }, this));
      }
    };
    return Stage;
  })();
  Stage.Global = (function() {
    __extends(Global, Stage);
    function Global() {
      Global.__super__.constructor.apply(this, arguments);
    }
    Global.prototype.global = true;
    return Global;
  })();
  module.exports = Stage;
}).call(this);
