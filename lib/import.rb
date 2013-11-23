require 'csv'
require 'breasal'
require 'uk_postcode'
require 'geo_ruby/shp'
require 'zip/filesystem'

class Import
  
  def self.setup
    
  end
  
  def self.postcodes
    path = postcode_path
    zip = Zip::File.open(path)
    lines = []
    zip.file.foreach("NSPL_AUG_2013_UK.csv") do |line|
      lines << line
      if lines.size >= 1000
        rows = CSV.parse(lines.join, {:headers => true})
        save rows
        lines = []
      end
    end
    rows = CSV.parse(lines.join, {:headers => true})
    save rows
  end
  
  def self.save(rows)
    rows.each do |row|
      p = UKPostcode.new(row[0])
      if p.valid?
        postcode = p.norm      
        easting = row[6].to_i
        northing = row[7].to_i
        county = row[10]
        council = row[11]
        ward = row[12]
        country = row[15]
        constituency = row[17]
    
        if country == "N92000002"
          en = Breasal::EastingNorthing.new(easting: easting, northing: northing, type: :ie)
        else
          en = Breasal::EastingNorthing.new(easting: easting, northing: northing)
        end
    
        ll = en.to_wgs84
    
        Postcode.create(:postcode        => postcode,
                        :eastingnorthing => "POINT(#{easting} #{northing})",
                        :latlng          => "POINT(#{ll[:latitude]} #{ll[:longitude]})",
                        :county          => county,
                        :council         => council,
                        :ward            => ward,
                        :constituency    => constituency,
                        :country         => country
                        )
      end
    end
  end
  
  def self.postcode_path
    path = Rails.root.join('lib', 'data', 'postcodes.zip')
  end
  
  def self.electoraldistricts
    file = Rails.root.join('lib', 'county_electoral_division_region').to_s
    boundaries(file, "electoraldistrict")
  end
  
  def self.parishes
    file = Rails.root.join('lib', 'parish_region').to_s
    boundaries(file, "parish")
  end
  
  def self.boundaries(file, type)
    GeoRuby::Shp4r::ShpFile.open(file) do |shp|
      shp.each do |shape|
        name = shape.data['NAME']
        code = shape.data['UNIT_ID']
        geom = shape.geometry.to_coordinates.first.first
        
        puts name
                
        Boundary.create(:name  => name,
                        :code  => code,
                        :type  => type,
                        :shape => geom
                        )
      end
    end
  end
  
  def self.add_extras
    ["electoraldistrict", "parish"].each do |type|
      boundaries = Boundary.where(:type => type)
      boundaries.each do |boundary|
        Postcode.within_polygon(eastingnorthing: boundary.shape).each do |postcode|
          postcode.send("#{type}=", boundary.code)
          postcode.save
        end
        puts boundary.name
      end
    end
  end
    
  def self.codes
    path = Rails.root.join('lib', 'data', 'codes.zip')
    zip = Zip::File.open(path)
    
    codes = {
      :council      => "basic_district_borough_unitary_info.nt",
      :ward         => "basic_district_borough_unitary_ward_info.nt",
      :county       => "basic_county_info.nt",
      :constituency => "basic_westminster_const_info.nt"
    }
    
    codes.each do |type, file|
      result = zip.file.read("codes/#{file}")
      areas = {}

      RDF::NTriples::Reader.new(result) do |reader|
        reader.each_statement do |statement|
          @s = statement
          areas[@s.subject.to_s] ||= {}
          areas[@s.subject.to_s][@s.predicate.to_s] = @s.object.to_s
        end
      end

      areas.each do |k, v|
        Code.create(:name   => v['http://www.w3.org/2000/01/rdf-schema#label'],
                    :os     => k.split('/').last,
                    :gss    => v['http://data.ordnancesurvey.co.uk/ontology/admingeo/gssCode'],
                    :kind   => v['http://www.w3.org/1999/02/22-rdf-syntax-ns#type'].split('/').last
                    )
      end
    end
  end
  
  def self.ni_codes
    codes = {
      :council      => "ni_councils.csv",
      :ward         => "ni_wards.csv",
      :constituency => "ni_constituencies.csv"
    }
    
    codes.each do |type, file|
      file = Rails.root.join('lib', "data/#{file}").to_s
      
      if type == :council
        type = "District"
      else
        type = "DistrictWard"
      end
      
      CSV.foreach(file) do |row|
        Code.create(:name => row[1],
                    :os   => nil,
                    :gss  => row[0],
                    :kind => type
                    )
      end
    end
  end
  
end