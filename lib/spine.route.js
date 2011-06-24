(function(Spine, $){  
  var Route = Spine.Route = Spine.Class.create();
  
  var hashStrip = /^#*/;
  
  Route.extend({
    routes: [],
    
    historySupport: ("history" in window),
    
    options: {
      trigger: true,
      history: false,
      shim: false
    },
        
    add: function(path, callback){
      if (typeof path === "object")
        for(var p in path) this.add(p, path[p]);
      else
        this.routes.push(this.init(path, callback));
    },
    
    setup: function(options){
      this.options = $.extend({}, this.options, options)
      
      if (this.options.history)
        this.history = this.historySupport && this.options.history;
        
      if ( this.history && !options.shim )
        $(window).bind("popstate", this.change);
      else if ( !options.shim )
        $(window).bind("hashchange", this.change);
      this.change();
    },
    
    unbind: function(){
      if (this.history)
        $(window).unbind("popstate", this.change);
      else
        $(window).unbind("hashchange", this.change);
    },
    
    navigate: function(){
      var args    = Spine.makeArray(arguments);
      var options = {};
      
      var lastArg = args[args.length - 1]
      if (typeof lastArg === "object") {
        options = args.pop();
      } else if (typeof lastArg === "boolean") {
        options.trigger = args.pop();
      }
      
      options = $.extend({}, this.options, options);
      
      var path = args.join("/");      
      if (this.path === path) return;      
      this.path = path;
      
      if (options.trigger) 
        this.matchRoute(this.path, options);

      if (options.shim) return;
      
      if (this.history)
        history.pushState({}, 
          document.title, 
          this.getHost() + this.path
        );
      else
        window.location.hash = this.path;
    },
    
    // Private
    
    getPath: function(){
      return window.location.pathname;
    },
    
    getHash: function(){
      return window.location.hash;
    },
    
    getHost: function(){
      return((document.location + "").replace(
        this.getPath() + this.getHash(), ""
      ));
    },
    
    getFragment: function(){
      return this.getHash().replace(hashStrip, "");
    },
    
    change: function(e){
      var path = (this.history ? this.getPath() : this.getFragment());
      if (path === this.path) return;
      this.path = path;
      this.matchRoute(this.path);
    },
    
    matchRoute: function(path, options){
      for (var i=0; i < this.routes.length; i++)
        if (this.routes[i].match(path, options)) return;      
    }
  });
  
  Route.proxyAll("change");
  
  var namedParam   = /:([\w\d]+)/g;
  var splatParam   = /\*([\w\d]+)/g;
  var escapeRegExp = /[-[\]{}()+?.,\\^$|#\s]/g;

  Route.include({    
    init: function(path, callback){
      this.names    = [];
      this.callback = callback;

      if (typeof path === "string") {
        var match;
        while (match = namedParam.exec(path) !== null)
          this.names.push(match[1]);
        
        path = path.replace(escapeRegExp, "\\$&")
                   .replace(namedParam, "([^\/]*)")
                   .replace(splatParam, "(.*?)");
                       
        this.route = new RegExp('^' + path + '$');
      } else {
        this.route = path;
      }
    },
    
    match: function(path, options){
      var match = this.route.exec(path)
      if ( !match ) return false;
      var params    = match.slice(1);
      options.match = params;
      
      if (this.names.length)
        for (var i=0; i < params.length; i++)
          options[this.names[i]] = params[i];

      this.callback.apply(this.callback, options);
      return true;
    }
  });
  
  Spine.Controller.fn.route = function(path, callback){
    Spine.Route.add(path, this.proxy(callback));
  };
  
  Spine.Controller.fn.routes = function(routes){
    for(var path in routes)
      this.route(path, routes[path]);
  };
  
  Spine.Controller.fn.navigate = function(){
    Spine.Route.navigate.apply(Spine.Route, arguments);
  };
})(Spine, Spine.$);