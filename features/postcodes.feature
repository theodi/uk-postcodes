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