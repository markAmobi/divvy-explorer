get '/stations' do
  @stations = Station.all
  erb :"stations/index"
end

get '/stations/:id' do
  @station = Station.find(params[:id])
  erb :"/stations/show"
end

get '/stations/:id/map' do
  @station = Station.find(params[:id])
  if request.xhr?
    latitude = @station.latitude
    longitude = @station.longitude
    # erb :"stations/show_map", layout: false

    {latitude: latitude, longitude: longitude}.to_json

  else
    "REQUEST WASNT XHR"
  end



end

get '/stations/:id/info' do
  @station = Station.find(params[:id])
  latitude = @station.latitude
  longitude = @station.longitude
  name = @station.name

  content_type :json
  live_data = Net::HTTP.get_response(URI.parse("http://www.divvybikes.com/stations/json")).body

  if request.xhr?
    {name: name, latitude: latitude, longitude: longitude, live_data: live_data}.to_json
  else
    "REQUEST WASNT XHR"
  end
end

# get '/divvy' do

# end