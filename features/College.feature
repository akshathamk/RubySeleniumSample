Feature: As a new user on www.collegeconfidential.com
I want to search for colleges based on the filters

Scenario: Find a School match using location and Major
	Given I am on the Home Page
	When I start searching for a college
	And I select the Location as "Ohio"
	And I select the Majors as "Bachelor"
	And I enter "Computer Software Engineering" as my preference
	Then I verify that "Miami University-Oxford" is a 100% match

