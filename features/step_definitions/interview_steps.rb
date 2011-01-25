Given /^I have an interview$/ do
  @position = Position.create(:title => "Ruby developer")

  @stage_one = @position.stage_at(1)
  @stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
  @stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
  
  @interview = @position.interviews.create(
      candidate_name: "mech",
      candidate_email: "mech@me.com",
      where: "Tampines, Singapore",
      when: Date.today
  )
end

Given /^The question (\d+) has not been answered$/ do |question_number|
  @response = @interview.responses.where(question_number: question_number).limit(1).first || @interview.responses.build(question_number: question_number)
  @response.answered?
end
