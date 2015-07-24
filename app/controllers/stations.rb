require 'net/http'
require 'nokogiri'
get '/stations' do
  @stations = Station.all
  erb :"stations/index"
end

get '/stations/graphs' do
  erb :"stations/graphs"
end

get '/stations/cool_stuff' do
  erb :"stations/cool_stuff"
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



get '/stations/graphs/show' do
  content_type :json
  live_data = Net::HTTP.get_response(URI.parse("http://www.divvybikes.com/stations/json")).body
  if request.xhr?
    {live_data: live_data}.to_json
  else
    "Request is Not XHR"
  end
end

## scrape about page of divvy.
get '/stations/divvy/about' do
  about_divvy = Net::HTTP.get_response(URI.parse("https://www.divvybikes.com/about")).body
  noko = Nokogiri::HTML(about_divvy)

  noko.search(".//aside").remove ## dont need this part.

  @needed_part = noko.search("#content").inner_html
  # p needed
  # "Hello World"
  erb :"/stations/about_divvy"
end

# get '/divvy' do

# end