Feature: Postcode Radius

  As as user
  I want to get data about postcodes within a defined radius
  
  Background:
    Given there are the following postcodes:
      | ABC 123  | 51.525994048543595 | -0.08776187896728516 |
      | ABC 345  | 51.52156160130253  | -0.08334159851074219 |
      | ABC 678  | 51.52967852566192  | -0.09698867797851562 |
      | ABC 910  | 51.52284331713511  | -0.12033462524414062 |
  
  Scenario: Getting HTML version of radius from postcode
    And I make a request for postcodes within 1 mile of "ABC 123"
    Then I should see 3 postcodes
    And I should see the following postcodes:
      | ABC 123 |
      | ABC 345 |
      | ABC 678 |

  Scenario: Getting HTML version of radius from latlng
    And I make a request for postcodes within 1 mile of 51.525994048543595,-0.08776187896728516
    Then I should see 3 postcodes
    And I should see the following postcodes:
      | ABC 123 |
      | ABC 345 |
      | ABC 678 |
  
  Scenario: Legacy redirects
    And I make a request to "/distance.php?lat=51.525994048543595&lng=-0.08776187896728516&distance=1"
    Then I should see 3 postcodes
    And I should see the following postcodes:
      | ABC 123 |
      | ABC 345 |
      | ABC 678 |
