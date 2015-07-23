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
