Feature: Recruiter add questions to positions
  In order to prepare question for each interview stage
  Recruiter wants to manage questions

  Scenario: Add question
    Given I am on "the stage number 1 page"
    And I am at question number 1
    When I select "Technical" from "Category"
    When I fill in the following:
      | Question | Explain to me meta-programming? |
      | Answer   | Write code to write more code   |
    And I press "Add"
    Then I should go to question number 2
