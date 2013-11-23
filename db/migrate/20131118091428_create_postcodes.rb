class CreatePostcodes < ActiveRecord::Migration
  def up
    execute <<-SQL
        CREATE EXTENSION postgis;
    SQL
    
    create_table :postcodes do |t|
      t.string :postcode
      t.point :eastingnorthing
      t.point :latlng, :geographic => true, :srid => 4326
      t.string :council
      t.string :county
      t.string :electoraldistrict
      t.string :ward
      t.string :constituency
      t.string :country
      t.string :parish
    end
    
    add_index :postcodes, :postcode, :unique => true
  end

  def down
  end
end
