json.array!(@postcodes) do |postcode|
  json.postcode postcode.postcode
  json.lat postcode.lat
  json.lng postcode.lng
  #json.distance postcode.distance_from(@postcode.latlng)
  json.uri postcode_url(postcode.postcode.gsub(' ', ''))
end