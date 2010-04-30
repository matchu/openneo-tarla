Feature: Vote on sightings
  In order to ensure that sightings are reliable
  As a user
  I want to be able to vote on whether or not Tarla is at a given location

Scenario: Vote up
  Given I have sightings at "http://www.neopets.com/water/", "http://www.neopets.com/desert/"
  And I am on the list of sightings
  When I press "She's here" within "#sighting-1 form.positive-vote"
  Then I should be on the list of sightings
  And I should see "1" within "#sighting-1 .score"
  And I should see "Thanks for your vote!" within "#sighting-1"

Scenario: Vote down
  Given I have sightings at "http://www.neopets.com/water/"
  And I am on the list of sightings
  When I press "She's gone" within "#sighting-1 form.negative-vote"
  Then I should be on the list of sightings
  And I should see "-1" within "#sighting-1 .score"
  And I should see "Thanks for your vote!" within "#sighting-1"
