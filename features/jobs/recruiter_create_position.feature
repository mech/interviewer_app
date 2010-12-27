Feature: Recruiter create position
  In order to setup an interview session
  Recruiter wants to manage positions

  @selenium
  Scenario: Add position
    Given I am on "the new position page"
    When I fill in the following:
      | Title       | Ruby developer          |
      | Description | Looking for Ruby ninja  |
      | Location    | Tampines                |
    And I press "Add position"
    Then I should see "Position has been created successfully"

  # Scenario: Categorize position
  #   Given position is not categorized
  #   When I select "IT" from "category"
  #   Then position will be organized
