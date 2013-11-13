class Boundary
  include Mongoid::Document
  include Mongoid::Geospatial
  
  field :name, type: String
  field :code, type: String
  field :type, type: String
  field :shape, type: Polygon
  
  spatial_index :shape
end