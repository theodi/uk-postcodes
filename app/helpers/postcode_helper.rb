module PostcodeHelper
  
  def prefixes
    {
      :geo              => RDF::Vocabulary.new("http://www.w3.org/2003/01/geo/wgs84_pos#"),
      :spatialrelations => RDF::Vocabulary.new("http://data.ordnancesurvey.co.uk/ontology/spatialrelations/"),
      :admingeo         => RDF::Vocabulary.new("http://statistics.data.gov.uk/def/administrative-geography/"),
      :elecgeo          => RDF::Vocabulary.new("http://statistics.data.gov.uk/def/electoral-geography/"),
      :osadmingeo       => RDF::Vocabulary.new("http://data.ordnancesurvey.co.uk/ontology/admingeo/"),
      :owl              => RDF::Vocabulary.new("http://www.w3.org/2002/07/owl#"),
      :rdfs             => RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")
    }
  end
  
  def generate_rdf(postcode)
    graph = RDF::Graph.new
    
    p = RDF::URI.new("http://uk-postcodes.com/postcode/#{postcode.postcode.gsub(" ", "")}")
    
    graph << [p, prefixes[:rdfs].label, postcode.postcode]
    graph << [p, RDF.type, RDF::URI.new("http://data.ordnancesurvey.co.uk/ontology/postcode/PostcodeUnit")]
    graph << [p, prefixes[:owl].sameAs, RDF::URI.new("http://data.ordnancesurvey.co.uk/id/postcodeunit/#{postcode.postcode.gsub(" ", "")}")]
    graph << [p, prefixes[:geo].lat, RDF::Literal.new(postcode.lat, :datatype => RDF::XSD.decimal) ]
    graph << [p, prefixes[:geo].long, RDF::Literal.new(postcode.lng, :datatype => RDF::XSD.decimal) ]
    graph << [p, prefixes[:spatialrelations].easting, postcode.easting.to_int ]
    graph << [p, prefixes[:spatialrelations].northing, postcode.northing.to_int ]
    
    @postcode.admin_areas.each do |title, area|
      graph << [p, prefixes[:spatialrelations]['t_spatiallyInside'], RDF::URI.new(area[:ons_uri]) ]
      os_uri = RDF::URI.new(area[:os_uri])
      graph << [p, prefixes[:spatialrelations][area[:type]], os_uri ]
      graph << [os_uri, prefixes[:rdfs].label, area[:name]]
    end
    
    return graph
        
  end
  
  def dump_graph(postcode)
    graph = generate_rdf(postcode)
    render :text => graph.dump(:rdfxml, :prefixes => prefixes)
  end
  
end