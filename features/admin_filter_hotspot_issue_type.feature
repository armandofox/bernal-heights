Feature: Filter hotspots by issue types

  As an admin, 
  I want to generate a report for all the hotspots of particular issue types, 
  so that I can have a better understanding of current distributions of crimes/problems and divert resources appropriately

Background:
  Given I am signed in as an admin
  And I am on the admin home page
  And my sample hotspots have been generated
  When I follow "View Hotspot Forms"

Scenario: See all hotspot forms by default 
  Then I should see all the current hotspot reports

Scenario: Filter hotspot forms by Illegal Drug Transactions
  When I check the following issue types: Illegal Drug Transactions
  And I uncheck the following issue types: Car Break-In,Abandoned Car,Broken Streetlight,Litter/Dumping Trash,Public Drinking and Noise,Other
  And I press "Filter"
  Then I should see "479 Prentiss St, San Francisco, CA 94110"
  And I should see "219 Richland Ave, San Francisco, CA 94110"
  And I should see "20 Eugenia Ave"
  And I should not see "25 Eugenia Ave"
  And I should not see "1561 Treat Ave"
  
Scenario: Filter hotspot forms by multiple issues (Car Break-In and Abandoned Car)
  When I check the following issue types: Car Break-In,Abandoned Car
  And I uncheck the following issue types: Broken Streetlight,Litter/Dumping Trash,Public Drinking and Noise,Other,Illegal Drug Transactions
  And I press "Filter"
  Then I should see "20 Eugenia Ave"
  And I should see "25 Eugenia Ave"
  And I should see "1561 Treat Ave"
  And I should not see "479 Prentiss St, San Francisco, CA 94110"
  And I should not see "219 Richland Ave, San Francisco, CA 94110"

Scenario: Filter hotspot forms by multiple issues with overlapping intersections (Car Break-In and Illegal Drug Transactions)
  When I check the following issue types: Car Break-In,Illegal Drug Transactions
  And I uncheck the following issue types: Abandoned Car,Broken Streetlight,Litter/Dumping Trash,Public Drinking and Noise,Other
  And I press "Filter"
  Then I should see "479 Prentiss St, San Francisco, CA 94110"
  And I should see "219 Richland Ave, San Francisco, CA 94110"
  And I should see "20 Eugenia Ave"
  And I should see "25 Eugenia Ave"
  And I should not see "1561 Treat Ave"
  
Scenario: Sad path where user unselects everything # we discussed that when users unselects everything -> it should return to default & display everything
  When I uncheck the following issue types: Car Break-In,Abandoned Car,Broken Streetlight,Illegal Drug Transactions,Litter/Dumping Trash,Public Drinking and Noise,Other
  Then I should see all the current hotspot reports