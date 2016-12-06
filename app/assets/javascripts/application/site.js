var siteName = {
  init: function() {
    
  },
  
  ifExists: function(elem, callback) {
    if(elem.length > 0) {
      callback();
    }
  }
}

$(document).ready(function() {
  siteName.init();
});