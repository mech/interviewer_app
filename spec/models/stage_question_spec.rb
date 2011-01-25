require 'spec_helper'

describe StageQuestion do
  let(:valid_position) { Position.create(:title => "Ruby developer") }
  let(:valid_stage) { valid_position.stage_at(1) }

  before do
    @valid_stage_question = valid_stage.stage_questions.create(
      :question => "Explain to me meta-programming?",
      :answer => "Write code to write more code",
      :points => 10
    )
  end

  describe "validations" do
    it "should be valid with valid attributes" do
      valid_position.should be_valid
    end
    
    it "should have a question" do
      @valid_stage_question.question = nil
      @valid_stage_question.should_not be_valid
      @valid_stage_question.should have(1).error_on(:question)
    end

    it "have some points" do
      @valid_stage_question.points = 0
      @valid_stage_question.should_not be_valid
      @valid_stage_question.should have(1).error_on(:points)
    end
  end

  describe "#next_question" do
    context "with no more question" do
      it "returns nil if there is no next question" do
        @valid_stage_question.next_question.should be_nil
      end
    end

    context "with more questions" do
      before do
        @next_question = valid_stage.stage_questions.create(
          :question => "Who invented Rails?",
          :answer => "DHH",
          :points => 5
        )
      end

      it "returns next question" do
        @valid_stage_question.next_question.should == @next_question
      end
    end
  end
end
