json.postcode @postcode.postcode
json.geo do
  json.lat @postcode.lat
  json.lng @postcode.lng
  json.easting @postcode.easting
  json.northing @postcode.northing
  json.geohash @postcode.geohash
end
json.administrative do
  @postcode.admin_areas.each do |title, area|
    json.set!(title) do
      json.title area[:name]
      json.uri area[:ons_uri]
      json.code area[:gss]
    end
  end
end