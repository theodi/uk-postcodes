@postcode
Feature: Accessing postcode data
    
    As a user
    I want to access postcode data
    So I can use it in my application
    
    Scenario: Access HTML version
      Given I access the page for "AB1 0AA"
      Then I should see the following details:
        | latitude         | 57.101478 |
        | longitude        | -2.242835 |
        | easting          | 385386 |
        | northing         | 801193 |
        | geohash_uri      | http://geohash.org/gfnkugnb4phb |
        | openly_local_url | http://openlylocal.com/areas/postcodes/AB10AA |
        | council          | Aberdeen City |
        | ward             | Lower Deeside  |
        | constituency     | Aberdeen South |
      
    Scenario: Access JSON version
      Given I access the JSON version of "AB1 0AA"
      Then I should see the following json:
      """
      {
        "postcode": "AB1 0AA",
        "geo": {
            "lat": 57.10147801540051,
            "lng": -2.2428351220462,
            "easting": 385386.0,
            "northing": 801193.0,
            "geohash": "http://geohash.org/gfnkugnb4phb"
        },
        "administrative": {
          "council": {
            "title": "Aberdeen City",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/S12000033",
            "code": "S12000033"
            },
            "ward": {
                "title": "Lower Deeside",
                "uri": "http://statistics.data.gov.uk/id/statistical-geography/S13002484",
                "code": "S13002484"
            },
          "constituency": {
              "title": "Aberdeen South",
              "uri": "http://statistics.data.gov.uk/id/statistical-geography/S14000002",
              "code": "S14000002"
          }
        }
      }
      """
  
    Scenario: Access XML version
      Given I access the XML version of "AB1 0AA"
      Then I should see the following xml:
      """
      <result>
        <postcode>AB1 0AA</postcode>
        <geo>
          <lat>57.10147801540051</lat>
          <lng>-2.2428351220462</lng>
          <easting>385386.0</easting>
          <northing>801193.0</northing>
          <geohash>http://geohash.org/gfnkugnb4phb</geohash>
        </geo>
        <administrative>
          <council>
            <title>Aberdeen City</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/S12000033</uri>
            <code>S12000033</code>
          </council>
          <ward>
            <title>Lower Deeside</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/S13002484</uri>
            <code>S13002484</code>
          </ward>
          <constituency>
            <title>Aberdeen South</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/S14000002</uri>
            <code>S14000002</code>
          </constituency>
        </administrative>
      </result>
      """

      Scenario: Access RDF version
        Given I access the RDF version of "AB1 0AA"
        Then I should see the following rdf:
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:ns0="http://data.ordnancesurvey.co.uk/ontology/postcode/" xmlns:spatialrelations="http://data.ordnancesurvey.co.uk/ontology/spatialrelations/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#">
          <ns0:PostcodeUnit rdf:about="http://uk-postcodes.com/postcode/AB10AA">
            <spatialrelations:UnitaryAuthority>
              <rdf:Description rdf:about="http://data.ordnancesurvey.co.uk/id/7000000000030421">
                <rdfs:label>Aberdeen City</rdfs:label>
              </rdf:Description>
            </spatialrelations:UnitaryAuthority>
            <spatialrelations:UnitaryAuthorityWard>
              <rdf:Description rdf:about="http://data.ordnancesurvey.co.uk/id/7000000000043300">
                <rdfs:label>Lower Deeside</rdfs:label>
              </rdf:Description>
            </spatialrelations:UnitaryAuthorityWard>
            <spatialrelations:WestminsterConstituency>
              <rdf:Description rdf:about="http://data.ordnancesurvey.co.uk/id/7000000000033487">
                <rdfs:label>Aberdeen South</rdfs:label>
              </rdf:Description>
            </spatialrelations:WestminsterConstituency>
            <spatialrelations:easting rdf:datatype="http://www.w3.org/2001/XMLSchema#integer">385386</spatialrelations:easting>
            <spatialrelations:northing rdf:datatype="http://www.w3.org/2001/XMLSchema#integer">801193</spatialrelations:northing>
            <spatialrelations:t_spatiallyInside rdf:resource="http://statistics.data.gov.uk/id/statistical-geography/S12000033"/>
            <spatialrelations:t_spatiallyInside rdf:resource="http://statistics.data.gov.uk/id/statistical-geography/S13002484"/>
            <spatialrelations:t_spatiallyInside rdf:resource="http://statistics.data.gov.uk/id/statistical-geography/S14000002"/>
            <rdfs:label>AB1 0AA</rdfs:label>
            <owl:sameAs rdf:resource="http://data.ordnancesurvey.co.uk/id/postcodeunit/AB10AA"/>
            <geo:lat rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">57.10147801540051</geo:lat>
            <geo:long rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">-2.2428351220462</geo:long>
          </ns0:PostcodeUnit>
        </rdf:RDF>
        """