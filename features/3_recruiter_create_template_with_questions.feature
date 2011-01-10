Feature: Recruiter create template with questions
  In order to share questions as a template
  As a recruiter or hiring manager
  I want to make a template out of several questions

  Scenario: Add template without regards to position
    Given I am on "the new template page"
    When I fill in "Name" with "My first template"
    And I press "Add template"
    Then I should go to question number 1

  @javascript
  Scenario: Add question to template
    Given I have a template
    Given I am on "the show template page"
    And I am at question number 1
    When I select "Technical" from "Category"
    When I fill in the following:
      | Question          | Explain to me meta-programming? |
      | Expected answer   | Write code to write more code   |
      | question_points   | 20                              |
    And I press "Add question"
    Then I should go to question number 2
