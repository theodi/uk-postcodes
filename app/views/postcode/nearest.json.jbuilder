json.array!(@postcodes) do |json, postcode|
  json.postcode postcode.postcode
  json.lat postcode.lat
  json.lng postcode.lng
  json.distance postcode.distance_from(@postcode.latlng)
end