@postcode
Feature: Reverse geocode

    As a user
    I want to get the nearest postcode to a latitude
    So I can reverse geocode
    
    Scenario: Get nearest postcode to latitude and longitude
      Given I access the latitude and longitude page for "57.10147801540051,-2.2428351220462"
      Then I should be redirected to "AB1 0AA"