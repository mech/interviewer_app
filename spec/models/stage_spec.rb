require 'spec_helper'

describe Stage do
  let(:valid_position) { Position.create(:title => "Ruby developer") }
  let(:stage_one) { valid_position.stage_at(1) }

  describe "#questions" do
    it "house a series of interview questions"
  end

  describe "#next_stage" do
    it "knows its next stage given enough point"

    it "can go to next stage if point is sufficient"

    it "should not go to next stage if point is insufficient"
  end

  describe "#previous_stage" do
    it "knows its previous stage"
  end
  
  describe "#leader" do
    it "should know who is the leader on this stage"
  end

  describe "#stage_question_at" do
    before do
      @qn_1 = stage_one.stage_questions.create(:question_number => 1, :question => "One")
      @qn_2 = stage_one.stage_questions.create(:question_number => 1, :question => "Two")
      @qn_2.question_number = 1; @qn_2.save
    end

    it "accepts one Integer argument" do
      lambda {
        stage_one.stage_question_at
      }.should raise_exception(ArgumentError)
    end

    it "returns nil if number argument is nil" do
      stage_one.stage_question_at(nil).should be_nil
    end

    it "raises RepeatedQuestionNumberError when finding more than one record" do
      lambda {
        stage_one.stage_question_at(1)
      }.should raise_exception(Exceptions::RepeatedQuestionNumberError)
    end
  end
end
