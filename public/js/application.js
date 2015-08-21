$(document).ready(function() {
  $('.button-collapse').sideNav();
      event.preventDefault();
      var url = $(this).attr("href");
      var request = $.ajax({
        method: "GET",
        url: url
      });
      request.done(function(response){
        var pos = JSON.parse(response);
        initialize(pos.latitude, pos.longitude);
      });
  });

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
      method: "GET",
      dataType: "json"
    });

    request.done(getGraph);
  });

}); //end of document ready.



function getGraph(response){
  var live_data = JSON.parse(response.live_data);
  var all_stations = live_data.stationBeanList;
  var available_bikes = all_stations.map(function(station){
    return station.availableBikes;
  });
  var station_names = all_stations.map(function(station){
    return station.stationName;
  });

    $('#graph-container').highcharts({
      title: {
            text: 'Number of Available Bikes',
            x: -20 //center
        },
        xAxis: {
            categories: station_names
        },
        yAxis: {
            title: {
                text: 'Number of Bikes'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{

            data: available_bikes
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

  $("#executionTime").html("Time of obtaining data is: " + live_data.executionTime);
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
