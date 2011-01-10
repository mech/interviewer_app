Feature: Recruiter add questions to positions
  In order to prepare question for each interview stage
  Recruiter wants to manage questions

  @javascript
  Scenario: Add question
    Given I have a position
    Given I am on "the stage number 1 page"
    And I am at question number 1
    When I select "Technical" from "Category"
    When I fill in the following:
      | Question              | Explain to me meta-programming? |
      | Expected answer       | Write code to write more code   |
      | stage_question_points | 20                              |
    And I press "Add question"
    Then I should go to question number 2
