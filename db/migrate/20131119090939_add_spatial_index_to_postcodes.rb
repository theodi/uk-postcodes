class AddSpatialIndexToPostcodes < ActiveRecord::Migration
  def change
    execute <<-SQL
        CREATE INDEX postcode_latlng ON postcodes USING GIST ( latlng );
    SQL
  end
end
