Given /^I have a position$/ do
  @position = Position.create(:title => "Ruby developer")
end

Given /^I am at question number (\d+)$/ do |question_number|
  page.should have_css("#qn_#{question_number}")
end

Then /^I should go to question number (\d+)$/ do |question_number|
  page.should have_css("#qn_#{question_number}")
end

Given /^I have a template$/ do
  @template = Template.create(:name => "Mid-level Project Manager")
end

Given /^I have a pin stage$/ do
  @position = Position.create(:title => "Ruby developer")
  @pin_stage = PinStage.create(:position_id => @position.id, :stage_number => @position.stage_at(1).stage_number)
end

Given /^The template has (\d+) questions$/ do |number_of_questions|
  number_of_questions.to_i.times do
    @template.questions << Question.new(:category => "Direct", :question => "test", :answer => "test", :points => 10)
  end

  @template.save
end

# Template drag and drop

When /^I start to drag first template to first pin stage$/ do
  draggable = page.find("div.ui-draggable")
  droppable = page.find("a.ui-droppable")

  draggable.drag_to(droppable)
end

Then /^I should have (\d+) questions saved to my stage$/ do |number_of_questions|
  PinStage.find(@pin_stage.id).stage.stage_questions.count.should == number_of_questions.to_i
end
