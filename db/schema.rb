# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131118222201) do

  create_table "boundaries", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "type"
    t.spatial "shape", :limit => {:srid=>0, :type=>"polygon"}
  end

  add_index "boundaries", ["code"], :name => "index_boundaries_on_code", :unique => true

  create_table "codes", :force => true do |t|
    t.string "name"
    t.string "snac"
    t.string "os"
    t.string "gss"
    t.string "kind"
  end

  create_table "postcodes", :force => true do |t|
    t.string  "postcode"
    t.spatial "latlng",            :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.string  "council"
    t.string  "county"
    t.string  "electoraldistrict"
    t.string  "ward"
    t.string  "constituency"
    t.string  "country"
    t.string  "parish"
    t.spatial "eastingnorthing",   :limit => {:srid=>0, :type=>"point"}
  end

  add_index "postcodes", ["postcode"], :name => "index_postcodes_on_postcode", :unique => true

end
