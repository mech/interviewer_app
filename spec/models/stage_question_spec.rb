require 'spec_helper'

describe StageQuestion do
  let(:valid_position) { Position.create(:title => "Ruby developer") }
  let(:valid_stage) { valid_position.stages.first }
  let(:valid_stage_question) {
    valid_stage.questions.build(
        :question => "Explain to me meta-programming?",
        :answer => "Write code to write more code"
    )
  }

  describe "validations" do
    it "should be valid with valid attributes" do
      valid_position.should be_valid
    end
    
    it "should have a question" do
      valid_stage_question.question = nil
      valid_stage_question.should_not be_valid
      valid_stage_question.should have(1).error_on(:question)
    end
  end
end
