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
        unless area[:gss] == "999999999"
          unless @postcode.ni?
            xml.uri area[:ons_uri]
          end
          xml.code area[:gss]
        else
          xml.uri area[:os_uri]
          xml.code area[:os]
        end
      end
    end
  end
end