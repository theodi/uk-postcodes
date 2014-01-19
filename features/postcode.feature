@postcode
Feature: Access postcodes
  
  As a user
  I want to access information about postcodes
  So I can see it with my eyes
  
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
      
  Scenario: Redirects are in place
    Given I try and access the page for "AB1 0AA" with a space
    Then I should be redirected to the canonical URL for the postcode

  Scenario: Access invalid postcode
    Given I access the page for "BCDZSD"
    Then the response should be "404"

  Scenario: Access nonexistent postcode
    Given I access the page for "SW1A 1AA"
    Then the response should be "404"

  Scenario: Invalid postcode on redirect  
    Given I make a request to "/postcode/search?q=ABC%20123"
    Then the response should be "404"
    And I should see the error "Postcode ABC 123 is not valid"