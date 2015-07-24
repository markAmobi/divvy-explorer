
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

// function showInfo(response){
//   console.log(response);
// }
  /// get divvy live json feed
  $("body").on("click","#show_info",function(event){
    event.preventDefault();
    var url = $(this).attr("href");
    // debugger;
    var request = $.ajax({
      method: "GET",
      url: url,
      dataType: "json"
    });

    request.done(parseResponse);
  });


  $("body").on("click", "#show-graphs", function(){
    event.preventDefault();

    var url = $(this).attr("href");
    var request = $.ajax({
      url: url,
      method: "GET"
    });

    request.done(getGraph);
  });

}); //end of document ready.



function getGraph(response){
  debugger;

    //TODO: get live feed data into highchart stuff.
     // new Highcharts.Chart({
    $('#graph-container').highcharts({
      chart: {
              type: 'bar'
          },
          title: {
              text: 'Fruit Consumption'
          },
          xAxis: {
              categories: ['Apples', 'Bananas', 'Oranges']
          },
          yAxis: {
              title: {
                  text: 'Fruit eaten'
              }
          },
          series: [{
              name: 'Jane',
              data: [1, 0, 4]
          }, {
              name: 'John',
              data: [5, 7, 3]
          }]

    });
}


//parse response of live data.
function parseResponse(response){
  // debugger;
  var name = response.name;
  var latitude = response.latitude;
  var longitude = response.longitude;
  var live_data = JSON.parse(response.live_data);
  var all_stations = live_data.stationBeanList;
  var current_station = all_stations.filter(function(station){
    return station.stationName === name;
  })[0] //bad code make this better.

  $("#location").html("Address is: " + current_station.location);
  $("#availableDocks").html("Number of available docks is: "+current_station.availableDocks);
  $("#totalDocks").html("Total number of docks is: " + current_station.totalDocks);
  $("#availableBikes").html("Number of bikes available is: " + current_station.availableBikes);
}

//simple google maps stuff.
 function initialize(latitude, longitude) {
    var myCenter = new google.maps.LatLng(latitude,longitude)
    var mapProp = {
      center:myCenter,
      zoom:16,
      mapTypeId:google.maps.MapTypeId.ROADMAP
    };
    var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

    var marker=new google.maps.Marker({
      position:myCenter,
    });
    marker.setMap(map);
  }
