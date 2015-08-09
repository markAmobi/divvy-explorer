require 'net/http'
require 'nokogiri'
require 'rubygems'
require 'oauth'


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


# get '/twitter_data' do
#   # The consumer key identifies the application making the request.
#   # The access token identifies the user making the request.
#   consumer_key = OAuth::Consumer.new(
#       "4HfmdxZWTAbUZAuD4GItdM2V3",
#       "JVuDF79hXOilwlGJK5MSxVyOhrc2KHTFlvETuuorGeS1f5HcvT")
#   access_token = OAuth::Token.new(
#       "3011781492-tBd1jEVTt622FaKtdmqEdZPeGH8e9RPwOK0X7Eo",
#       "CeZeOI4AhsKGG98VRSGAjCPBOS4VU7HxW3cSwLDy5gY2i")

#   # All requests will be sent to this server.
#   baseurl = "https://api.twitter.com"
#   # The verify credentials endpoint returns a 200 status if
#   # the request is signed correctly.
#   query = "q=on%20fleek&src=tyah&count=100"
#   # https://api.twitter.com/1.1/search/tweets.json
#   address = URI("#{baseurl}/1.1/search/tweets.json?#{query}")
#   # Set up Net::HTTP to use SSL, which is required by Twitter.
#   http = Net::HTTP.new address.host, address.port
#   http.use_ssl = true
#   http.verify_mode = OpenSSL::SSL::VERIFY_PEER

#   # Build the request and authorize it with OAuth.
#   request = Net::HTTP::Get.new address.request_uri
#   request.oauth! http, consumer_key, access_token

#   # Issue the request and return the response.
#   http.start
#   content_type :json
#   response = http.request request
#   # puts "The response status was #{response.code}"
#   # puts "the response was #{response.body}"
#   response.body.to_json

# end

# get '/twitter_data' do
#   baseurl = "http://google.com/trends/"
#   query = "explore#q=fleek"
#   # address = URI("#{baseurl}#{query}")
#   # http = Net::HTTP.new address.host, address.port
#   # http.use_ssl = true
#   # http.verify_mode = OpenSSL::SSL::VERIFY_PEER

#   live_data = Net::HTTP.get_response(URI.parse("http://www.google.com/trends/fetchComponent?hl=en-US&q=%22on%20fleek%22&cid=TIMESERIES_GRAPH_0&export=3&w=500&h=300")).body
#   # live_data = Net::HTTP.get_response(URI.parse("http://www.divvybikes.com/stations/json")).body

#   if request.xhr?
#     {live_data: live_data}.to_json
#   else
#     "REQUEST WASNT XHR"
#   end
# end

# get '/divvy' do

# end