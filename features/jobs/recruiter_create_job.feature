Feature: Recruiter create job position
  In order to setup an interview session
  Recruiter wants to manage job positions

  Scenario: Add job
    Given I am on "the new job page"
    When I fill in the following:
      | Title       | Ruby developer          |
      | Description | Looking for Ruby ninja  |
      | Location    | Tampines                |
    And I press "Add a new job"
    Then I should see "Job has been created successfully"

  # Scenario: Categorize job
  #   Given job is not categorized
  #   When I select "IT" from "category"
  #   Then job will be organized
