@postcode
Feature: Reverse geocode

    As a user
    I want to get the nearest postcode to a latitude
    So I can reverse geocode
    
    Scenario: Get nearest postcode to latitude and longitude
      Given I access the latitude and longitude page for "57.10147801540051,-2.2428351220462"
      Then I should be redirected to "AB1 0AA"
      
    Scenario: Preserve formatting
      Given I request the latitude and longitude page for "57.10147801540051,-2.2428351220462" in xml format
      Then I should be redirected to "AB1 0AA" in xml format

    Scenario: Missing longitude
      Given I request the latitude and longitude page for "57.10147801540051," in json format
      Then the response should be "422"
      And I should see the error "You must specify a latitude and longitude"

    Scenario: Out of range requests
      Given I request the latitude and longitude page for "0,0" in json format
      Then the response should be "404"
      And I should see the error "No postcode found for 0,0"