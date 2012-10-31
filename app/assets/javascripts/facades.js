(function(){
  var root = this,
      F    = {};
  
  F.mobile = (function(){
    return (/android|webos|iphone|ipad|ipod|blackberry/i).test(navigator.userAgent);
  })();

  F.device = (function(){
    if((/ipad/i).test(navigator.userAgent)) return 'ipad';
    if((/iphone|ipod/i).test(navigator.userAgent)) return 'iphone';
    if((/android/i).test(navigator.userAgent)) return 'android';
    if((/webos/i).test(navigator.userAgent)) return 'webos';
    if((/blackberry/i).test(navigator.userAgent)) return 'blackberry';
  })();
  
  F.click = ( F.mobile == true ) ? "touchstart" : "click";
  
  F.mobileResize = function(){
    var doc = root.document, viewportmeta, scrollTop, bodycheck;
  
    // If there's a hash, or addEventListener is undefined, stop here
    if( !location.hash && root.addEventListener ){
      window.scrollTo( 0, 1 );
      scrollTop = 1;
      
      function getScrollTop(){
        return root.pageYOffset || doc.compatMode === "CSS1Compat" && doc.documentElement.scrollTop || doc.body.scrollTop || 0;
      }
    
      //reset to 0 on bodyready, if needed
      bodycheck = setInterval(function(){
        if( doc.body ){
          clearInterval( bodycheck );
          scrollTop = getScrollTop();
          win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
        }}, 15 );
    
      win.addEventListener( "load", function(){
        setTimeout(function(){
          //at load, if user hasn't scrolled more than 20 or so...
          if( getScrollTop() < 20 ){
            //reset to hide addr bar at onload
            win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
          }
        }, 0);
      });
    }
  
    if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
      viewportmeta = document.querySelector('meta[name="viewport"]');
      if (viewportmeta) {
        viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0';
        document.body.addEventListener('gesturestart', function () {
          viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
          }, false);
        }
    }
  };
  
  root.F = F;
  
})( this );