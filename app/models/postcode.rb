class Postcode < ActiveRecord::Base
  
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  set_rgeo_factory_for_column(:latlng, RGeo::Geographic.spherical_factory(:srid => 4326))
  
  ADMIN_AREAS = [:council, :county, :ward, :constituency]
  
  def lat
    self.latlng.x
  end
  
  def lng
    self.latlng.y
  end
  
  def easting
    self.eastingnorthing.x
  end
  
  def northing
    self.eastingnorthing.y
  end
  
  def distance_from(lat, lng)
    d = Geodesic::dist_haversine(self.lat, self.lng, lat, lng)
    (d * 0.6214).round(4)
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
      unless c.nil?
        {
          :name => c.name,
          :gss => c.gss,
          :ons_uri => "http://statistics.data.gov.uk/id/statistical-geography/#{c.gss}",
          :os_uri => "http://data.ordnancesurvey.co.uk/id/#{c.os}",
          :kind => c.kind
        }
      else
        {}
      end 
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