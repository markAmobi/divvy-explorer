$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()



  // google.maps.event.addDomListener($("#show_map"), 'station_map', initialize);

  $("body").on("click","#show_map", function(){
    // console.log(event);
      event.preventDefault();
      var url = $(this).attr("href");
      // console.log(url);
      // debugger;
      var request = $.ajax({
        method: "GET",
        url: url
      });

      request.done(function(response){
        // debugger;
        var pos = JSON.parse(response);
        initialize(pos.latitude, pos.longitude);

      });

  });

});


 function initialize(latitude, longitude) {
    var mapProp = {
      center:new google.maps.LatLng(latitude,longitude),
      zoom:20,
      mapTypeId:google.maps.MapTypeId.ROADMAP
    };
    var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
  }
