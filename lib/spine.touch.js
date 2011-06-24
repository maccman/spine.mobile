(function(Spine, $){
  Spine.preventDefaultTouch = $.preventDefaultTouch = function(){
    $("body").bind("touchmove", function(e){
      e.preventDefault();
    });
  };
  
  $.support.touch = ('ontouchstart' in window);
  Spine.Controller.fn.tap = $.support.touch ? "tap" : "click";
})(Spine, Spine.$);