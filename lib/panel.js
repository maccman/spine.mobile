(function() {
  var $, Gfx, Panel, Stage;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $ = Spine.$;
  Gfx = require('gfx');
  Stage = require('./stage');
  Panel = (function() {
    __extends(Panel, Stage);
    Panel.prototype.title = false;
    Panel.prototype.viewport = false;
    function Panel() {
      var _ref, _ref2;
      Panel.__super__.constructor.apply(this, arguments);
      this.el.removeClass('stage').addClass('panel');
      if (this.title) {
        this.header.append($('<h2 />').html(this.title));
      }
      if ((_ref = this.stage) == null) {
        this.stage = Stage.globalStage();
      }
      if ((_ref2 = this.stage) != null) {
        _ref2.add(this);
      }
    }
    Panel.prototype.addButton = function(text, callback) {
      var button;
      if (typeof callback === 'string') {
        callback = this[callback];
      }
      button = $('<button />').text(text);
      button.tap(this.proxy(callback));
      this.header.append(button);
      return button;
    };
    Panel.prototype.activate = function(params) {
      var effect;
      if (params == null) {
        params = {};
      }
      effect = params.transition || params.trans;
      if (effect) {
        return this.effects[effect].apply(this);
      } else {
        this.content.add(this.header).show();
        return this.el.addClass('active');
      }
    };
    Panel.prototype.deactivate = function(params) {
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
    Panel.prototype.effects = {
      left: function() {
        this.el.addClass('active');
        this.content.gfxSlideIn(this.effectOptions({
          direction: 'left'
        }));
        return this.header.gfxSlideIn(this.effectOptions({
          direction: 'left',
          fade: true,
          distance: 50
        }));
      },
      right: function() {
        this.el.addClass('active');
        this.content.gfxSlideIn(this.effectOptions({
          direction: 'right'
        }));
        return this.header.gfxSlideIn(this.effectOptions({
          direction: 'right',
          fade: true,
          distance: 50
        }));
      }
    };
    Panel.prototype.reverseEffects = {
      left: function() {
        this.content.gfxSlideOut(this.effectOptions({
          direction: 'right'
        }));
        this.header.gfxSlideOut(this.effectOptions({
          direction: 'right',
          fade: true,
          distance: 50
        }));
        return this.content.queueNext(__bind(function() {
          return this.el.removeClass('active');
        }, this));
      },
      right: function() {
        this.content.gfxSlideOut(this.effectOptions({
          direction: 'left'
        }));
        this.header.gfxSlideOut(this.effectOptions({
          direction: 'left',
          fade: true,
          distance: 50
        }));
        return this.content.queueNext(__bind(function() {
          return this.el.removeClass('active');
        }, this));
      }
    };
    return Panel;
  })();
  module.exports = Panel;
}).call(this);
