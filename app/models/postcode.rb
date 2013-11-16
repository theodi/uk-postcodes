class Postcode
  include Mongoid::Document
  include Mongoid::Geospatial
  
  field :postcode, type: String
  field :eastingnorthing, type: Point
  field :latlng, type: Array, type: Point
  field :council
  field :county
  field :electoraldistrict
  field :ward
  field :constituency
  field :country
  
  spatial_index :eastingnorthing
  spatial_index :latlng
  
  index({ postcode: 1 }, { unique: true, name: "postcode_index" })
  
  ADMIN_AREAS = [:council, :county, :ward, :constituency]
  
  def lat
    self.latlng[0]
  end
  
  def lng
    self.latlng[1]
  end
  
  def easting
    self.eastingnorthing[0]
  end
  
  def northing
    self.eastingnorthing[1]
  end
  
  def distance_from(latlng)
    d = Geodesic::dist_haversine(self.lat, self.lng, latlng[0], latlng[1])
    d.round(4)
  end
  
  def admin_areas
    areas = {}
    ADMIN_AREAS.each do |area|
      unless self.send(area).nil? || self.send(area).include?("99999999")
        areas[area] = self.send("#{area}_details")
      end
    end
    areas
  end
  
  def geohash
    hash = GeoHash.encode(self.lat, self.lng)
    "http://geohash.org/#{hash}"
  end
  
  def method_missing(method_name, *args, &blk)
    val = method_name.to_s.match(/(.+)_details/)
    unless val.nil?
      c = Code.where(:gss => self.send(val[1])).first
      {
        :name => c.name,
        :gss => c.gss,
        :ons_uri => "http://statistics.data.gov.uk/id/statistical-geography/#{c.gss}",
        :os_uri => "http://data.ordnancesurvey.co.uk/id/#{c.os}",
        :type => c.type
      }
    else
      super
    end
  end
  
  def to_csv
    CSV.generate do |csv|
      csv << [
          self.postcode,
          self.lat,
          self.lng,
          self.easting,
          self.northing,
          geohash,
          county_details[:gss],
          county_details[:name],
          council_details[:gss],
          council_details[:name],
          ward_details[:gss],
          ward_details[:name]
        ]
    end
  end
end