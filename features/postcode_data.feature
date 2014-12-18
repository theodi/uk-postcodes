@postcode
Feature: Accessing postcode data

    As a user
    I want to access postcode data
    So I can use it in my application

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
      And I access the JSON version of "WS14 9SQ"
      Then I should see the following json:
      """
      {
        "postcode": "WS14 9SQ",
        "geo": {
          "lat": 52.67752501534847,
          "lng": -1.8148108086293673,
          "easting": 412617.0,
          "northing": 308885.0,
          "geohash": "http://geohash.org/gcqewtwkzf6u"
        },
        "administrative": {
          "council": {
            "title": "Lichfield",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/E07000194",
            "code": "E07000194"
          },
          "county": {
            "title": "Staffordshire",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/E10000028",
            "code": "E10000028"
          },
          "ward": {
            "title": "St. John's",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/E05006958",
            "code": "E05006958"
          },
          "constituency": {
            "title": "Lichfield",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/E14000791",
            "code": "E14000791"
          },
          "parish": {
            "title": "Lichfield CP",
            "uri": "http://statistics.data.gov.uk/id/statistical-geography/E04008932",
            "code": "E04008932"
          },
          "electoral_district": {
            "title": "Lichfield City South",
            "uri": "http://data.ordnancesurvey.co.uk/id/7000000000042775",
            "code": "7000000000042775"
          }
        }
      }
      """

    @enable_caching
    Scenario: JSONP works correctly with caching
      Given I access the JSONP version of "AB1 0AA" with the callback "J50Npi.success"
      Then I should see the correct callback
      And I access the JSONP version of "AB1 0AA" with the callback "J50Npi.success2"
      Then I should see the correct callback

    Scenario: JSON requests with callbacks get redirected to JSONP
      Given I access the JSON version of "AB1 0AA" with the callback "J50Npi.success"
      Then I should be redirected to the JSONP version of the data
      And I should see the correct callback

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
      And I access the XML version of "WS14 9SQ"
      Then I should see the following xml:
      """
      <result>
        <postcode>WS14 9SQ</postcode>
        <geo>
          <lat>52.67752501534847</lat>
          <lng>-1.8148108086293673</lng>
          <easting>412617.0</easting>
          <northing>308885.0</northing>
          <geohash>http://geohash.org/gcqewtwkzf6u</geohash>
        </geo>
        <administrative>
          <council>
            <title>Lichfield</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/E07000194</uri>
            <code>E07000194</code>
          </council>
          <county>
            <title>Staffordshire</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/E10000028</uri>
            <code>E10000028</code>
          </county>
          <ward>
            <title>St. John's</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/E05006958</uri>
            <code>E05006958</code>
          </ward>
          <constituency>
            <title>Lichfield</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/E14000791</uri>
            <code>E14000791</code>
          </constituency>
          <parish>
            <title>Lichfield CP</title>
            <uri>http://statistics.data.gov.uk/id/statistical-geography/E04008932</uri>
            <code>E04008932</code>
          </parish>
          <electoral_district>
            <title>Lichfield City South</title>
            <uri>http://data.ordnancesurvey.co.uk/id/7000000000042775</uri>
            <code>7000000000042775</code>
          </electoral_district>
        </administrative>
      </result>
      """

      Scenario: Access RDF version
        Given I access the RDF version of "AB1 0AA"
        Then I should see the following rdf:
        """
        <?xml version='1.0' encoding='utf-8' ?>
        <rdf:RDF xmlns:geo='http://www.w3.org/2003/01/geo/wgs84_pos#' xmlns:ns0='http://data.ordnancesurvey.co.uk/ontology/postcode/' xmlns:osadmingeo='http://data.ordnancesurvey.co.uk/ontology/admingeo/' xmlns:owl='http://www.w3.org/2002/07/owl#' xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#' xmlns:rdfs='http://www.w3.org/2000/01/rdf-schema#' xmlns:spatialrelations='http://data.ordnancesurvey.co.uk/ontology/spatialrelations/'>
        <ns0:PostcodeUnit rdf:about='http://uk-postcodes.com/postcode/AB10AA'>
          <rdfs:label>AB1 0AA</rdfs:label>
          <osadmingeo:UnitaryAuthority>
            <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000030421'>
              <rdfs:label>Aberdeen City</rdfs:label>
            </rdf:Description>
          </osadmingeo:UnitaryAuthority>
          <osadmingeo:UnitaryAuthorityWard>
            <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000043300'>
              <rdfs:label>Lower Deeside</rdfs:label>
            </rdf:Description>
          </osadmingeo:UnitaryAuthorityWard>
          <osadmingeo:WestminsterConstituency>
            <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000033487'>
              <rdfs:label>Aberdeen South</rdfs:label>
            </rdf:Description>
          </osadmingeo:WestminsterConstituency>
          <spatialrelations:easting rdf:datatype='http://www.w3.org/2001/XMLSchema#integer'>385386</spatialrelations:easting>
          <spatialrelations:northing rdf:datatype='http://www.w3.org/2001/XMLSchema#integer'>801193</spatialrelations:northing>
          <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/S12000033' />
          <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/S13002484' />
          <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/S14000002' />
          <owl:sameAs rdf:resource='http://data.ordnancesurvey.co.uk/id/postcodeunit/AB10AA' />
          <geo:lat rdf:datatype='http://www.w3.org/2001/XMLSchema#decimal'>57.10147801540051</geo:lat>
          <geo:long rdf:datatype='http://www.w3.org/2001/XMLSchema#decimal'>-2.2428351220462</geo:long>
        </ns0:PostcodeUnit>
      </rdf:RDF>
        """
        And I access the RDF version of "WS14 9SQ"
        Then I should see the following rdf:
        """
        <?xml version='1.0' encoding='utf-8' ?>
        <rdf:RDF xmlns:geo='http://www.w3.org/2003/01/geo/wgs84_pos#' xmlns:ns0='http://data.ordnancesurvey.co.uk/ontology/postcode/' xmlns:osadmingeo='http://data.ordnancesurvey.co.uk/ontology/admingeo/' xmlns:owl='http://www.w3.org/2002/07/owl#' xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#' xmlns:rdfs='http://www.w3.org/2000/01/rdf-schema#' xmlns:spatialrelations='http://data.ordnancesurvey.co.uk/ontology/spatialrelations/'> 
          <ns0:PostcodeUnit rdf:about='http://uk-postcodes.com/postcode/WS149SQ'>
            <rdfs:label>WS14 9SQ</rdfs:label>
            <osadmingeo:CivilParish>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000014792'>
                <rdfs:label>Lichfield CP</rdfs:label>
              </rdf:Description>
            </osadmingeo:CivilParish>
            <osadmingeo:County>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000015052'>
                <rdfs:label>Staffordshire</rdfs:label>
              </rdf:Description>
            </osadmingeo:County>
            <osadmingeo:CountyElectoralDivision>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000042775'>
                <rdfs:label>Lichfield City South</rdfs:label>
              </rdf:Description>
            </osadmingeo:CountyElectoralDivision>
            <osadmingeo:District>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000014797'>
                <rdfs:label>Lichfield</rdfs:label>
              </rdf:Description>
            </osadmingeo:District>
            <osadmingeo:DistrictWard>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000014814'>
                <rdfs:label>St. John's</rdfs:label>
              </rdf:Description>
            </osadmingeo:DistrictWard>
            <osadmingeo:WestminsterConstituency>
              <rdf:Description rdf:about='http://data.ordnancesurvey.co.uk/id/7000000000024610'>
                <rdfs:label>Lichfield</rdfs:label>
              </rdf:Description>
            </osadmingeo:WestminsterConstituency>
            <spatialrelations:easting rdf:datatype='http://www.w3.org/2001/XMLSchema#integer'>412617</spatialrelations:easting>
            <spatialrelations:northing rdf:datatype='http://www.w3.org/2001/XMLSchema#integer'>308885</spatialrelations:northing>
            <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/E07000194' />
            <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/E10000028' />
            <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/E05006958' />
            <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/E14000791' />
            <spatialrelations:t_spatiallyInside rdf:resource='http://statistics.data.gov.uk/id/statistical-geography/E04008932' />
            <owl:sameAs rdf:resource='http://data.ordnancesurvey.co.uk/id/postcodeunit/WS149SQ' />
            <geo:lat rdf:datatype='http://www.w3.org/2001/XMLSchema#decimal'>52.67752501534847</geo:lat>
            <geo:long rdf:datatype='http://www.w3.org/2001/XMLSchema#decimal'>-1.8148108086293673</geo:long>
          </ns0:PostcodeUnit>
        </rdf:RDF>
        """

        Scenario: Access CSV version
          Given I access the CSV version of "AB1 0AA"
          Then I should see the following csv:
          """
          AB1 0AA,57.10147801540051,-2.2428351220462,385386.0,801193.0,http://geohash.org/gfnkugnb4phb,,,S12000033,Aberdeen City,S13002484,Lower Deeside
          """

        Scenario: Access invalid postcode
          Given I access the JSON version of "BCDZSD"
          Then the response should be "404"
          And I should see the error "Postcode BCDZSD is not valid"

        Scenario: Access nonexistent postcode
          Given I access the JSON version of "SW1A 1AA"
          Then the response should be "404"
          And I should see the error "Postcode SW1A1AA cannot be found"
