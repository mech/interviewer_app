Feature: Browse templates
  In order to select questions for my interview
  As a recruiter
  I want to browse templates and choose the suitable questions

  @javascript
  Scenario: Select templates and save it to stage
    Given I have a template
    And I have a pin stage
    And The template has 2 questions
    Given I am on "the browse templates page"
    When I start to drag first template to first pin stage
    # Then I should have 2 questions saved to my stage
    
