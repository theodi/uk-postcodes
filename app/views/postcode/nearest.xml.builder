xml.result do
  xml.postcodes do
    @postcodes.each do |postcode|
      xml.postcode do
        xml.postcode postcode.postcode
        xml.lat postcode.lat
        xml.lng postcode.lng
        xml.distance postcode.distance_from(@lat, @lng)
        xml.uri postcode_url(postcode.postcode.gsub(' ', ''))
      end
    end
  end
end