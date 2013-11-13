xml.result do
  xml.postcode @postcode.postcode
  xml.geo do
    xml.lat @postcode.lat
    xml.lng @postcode.lng
    xml.easting @postcode.easting
    xml.northing @postcode.northing
    xml.geohash @postcode.geohash
  end
  xml.administrative do
    @postcode.admin_areas.each do |title, area|
      xml.tag!(title) do
        xml.title area[:name]
        xml.uri area[:ons_uri]
        xml.code area[:gss]
      end
    end
  end
end