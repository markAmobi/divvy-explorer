get '/stations' do
  @stations = Station.all
  erb :"stations/index"
end

get '/stations/:id' do
  @station = Station.find(params[:id])
  erb :"/stations/show"
end

get '/stations/:id/map' do

  if request.xhr?

    erb :"stations/show_map", layout: false

  else
    "REQUEST WASNT XHR"
  end



end
