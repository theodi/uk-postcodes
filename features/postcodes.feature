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