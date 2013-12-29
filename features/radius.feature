Feature: Postcode Radius

  As as user
  I want to get data about postcodes within a defined radius
  
  Scenario: Getting HTML version of radius
    Given there are the following postcodes:
      | ABC 123  | 51.525994048543595 | -0.08776187896728516 |
      | ABC 345  | 51.52156160130253  | -0.08334159851074219 |
      | ABC 678  | 51.52967852566192  | -0.09698867797851562 |
      | ABC 910  | 51.52284331713511  | -0.12033462524414062 |
    And I make a request for postcodes within 1 mile of "ABC 123"
    Then I should see 3 postcodes
    And I should see the following postcodes:
      | ABC 123 |
      | ABC 345 |
      | ABC 678 |
