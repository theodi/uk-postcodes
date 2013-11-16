Feature: Importing data

  In order for UK Postcodes to work
  As a developer
  I need to import various data
  
  Scenario: Import postcodes
    Given I want to import postcodes from "/fixtures/postcodes.zip"
    When I run the postcode import task
    Then there should be 300 postcodes in the database
    
  Scenario: Import codes
    Given I run the code import tasks
    Then there should be 9244 codes in the database