Feature: Respond to question
  In order to rate candidate
  As a interviewer
  I want to make a comment and give points to candidate

  Scenario: Comment on question
    Given I have an interview
    And I am on "the interview question 1 page"
    And The question 1 has not been answered
    When I fill in "Good answer" for "Comment on candidate's performance"
    And I press "Award"
    Then I should be on "the interview question 2 page"
