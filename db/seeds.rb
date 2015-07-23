require 'csv'
Station.destroy_all

data = CSV.table("db/Divvy_Stations_2014-Q3Q4.csv")

data.each do |station|
  Station.create(given_id: station[:id],
                  name: station[:name],
                  longitude: station[:longitude],
                  latitude: station[:latitude],
                  dpcapacity: station[:dpcapacity],
                  dateCreated: station[:datecreated]
                  )
end