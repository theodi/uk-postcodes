Before('@postcode') do
  Import.stub(:postcode_path) { Rails.root.join('features', 'fixtures', 'postcodes.zip') }
  Import.postcodes
  Import.codes
end