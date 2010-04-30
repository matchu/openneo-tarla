Feature: Manage sightings
  In order to track Tarla
  As a user
  I want to create and view sightings

  Scenario: Sightings list
    Given I have sightings at "http://www.neopets.com/", "http://www.neopets.com/lab.phtml"
    When I go to the list of sightings
    Then I should see a link to "http://www.neopets.com/"
    And I should see a link to "http://www.neopets.com/lab.phtml"
  
  Scenario: Add a sighting
    Given I am on the new sighting page
    When I fill in "sighting_url" with "http://www.neopets.com/water/"
    And I press "Create Sighting"
    Then I should be on the list of sightings
    And I should see a link to "http://www.neopets.com/water/"
  
  Scenario: Invalid URL
    Given I am on the new sighting page
    When I fill in "sighting_url" with "http://www.example.com/water/"
    And I press "Create Sighting"
    Then I should see "Url needs to be from Neopets.com"
