Feature: Setup interview
  In order to arrange for an interview
  As a interviewer
  I want to have an interview

  Scenario: Create interview
    Given I have a position
    When I am on "the new interview page"
    When I fill in the following:
      | Candidate name  | mech                |
      | Candidate email | mech@me.com         |
      | Where           | Tampines, Singapore |
    And I press "Create interview"
    Then I should see "Interview has been created successfully."

