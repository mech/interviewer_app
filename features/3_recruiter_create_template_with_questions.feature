Feature: Recruiter create template with questions
  In order to share questions as a template
  As a recruiter or hiring manager
  I want to make a template out of several questions

  Scenario: Add template without regards to position
    Given I am on "the new template page"
    When I fill in "Name" with "My first template"
    And I press "Add template"
    Then I should go to question number 1
