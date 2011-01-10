Given /^I have a position$/ do
  @position = Position.create(:title => "Ruby developer")
end

Given /^I am at question number (\d+)$/ do |question_number|
  page.should have_css("#qn_#{question_number}")
end

Then /^I should go to question number (\d+)$/ do |question_number|
  page.should have_css("#qn_#{question_number}")
end
