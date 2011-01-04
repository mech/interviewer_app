require 'spec_helper'

describe Stage do
  let(:valid_position) { Position.create(:title => "Ruby developer") }
  let(:stage_one) { valid_position.stage_at(1) }

  describe "#next_stage" do
    it "knows its next stage given enough point"

    it "can go to next stage if point is sufficient"

    it "should not go to next stage if point is insufficient"
  end

  describe "#previous_stage" do
    it "knows its previous stage"
  end
  
  describe "#leader" do
    it "should know who is the leader at this stage"
  end

  context "save points" do
    it "falls back to full mark if exceed full mark" do
      stage_one.points = 20
      stage_one.save
      stage_one.points.should == stage_one.full_mark
    end
  end

  describe "#sort_questions" do
    before do
      @pos_1 = stage_one.stage_questions.create(:question => "Position 1", :points => 10)
      @pos_2 = stage_one.stage_questions.create(:question => "Position 2", :points => 20)
      @pos_3 = stage_one.stage_questions.create(:question => "Position 3", :points => 30)
    end

    it "sorts the questions given the ordering layout 3, 1, 2" do
      stage_one.sort_questions([3, 1, 2])
      @pos_1.question_number.should == 2
      @pos_2.question_number.should == 3
      @pos_3.question_number.should == 1
    end

    it "sorts the questions given the ordering layout 1, 2, 3" do
      stage_one.sort_questions([1, 2, 3])
      @pos_1.question_number.should == 1
      @pos_2.question_number.should == 2
      @pos_3.question_number.should == 3
    end

    it "sorts the questions given the ordering layout 2, 1, 3" do
      stage_one.sort_questions([2, 1, 3])
      @pos_1.question_number.should == 2
      @pos_2.question_number.should == 1
      @pos_3.question_number.should == 3
    end

    it "sorts the questions given the ordering layout 1, 3, 4, 2" do
      stage_one.sort_questions([1, 3, 4, 2])
      @pos_1.question_number.should == 1
      @pos_2.question_number.should == 3
      @pos_3.question_number.should == 2
    end

    it "sorts sequentially given nothing" do
      stage_one.sort_questions
      @pos_1.question_number.should == 1
      @pos_2.question_number.should == 2
      @pos_3.question_number.should == 3
    end

    it "ignores extra ordering layout" do
      stage_one.sort_questions([3, 1, 2, 4])
      @pos_1.question_number.should == 2
      @pos_2.question_number.should == 3
      @pos_3.question_number.should == 1
    end

    it "remains the same given the ordering layout 1, 2, 4, 3" do
      stage_one.sort_questions([1, 2, 4, 3])
      @pos_1.question_number.should == 1
      @pos_2.question_number.should == 2
      @pos_3.question_number.should == 3
    end

    it "accepts ordering layout as array of String" do
      stage_one.sort_questions(["3", "1", "2"])
      @pos_1.question_number.should == 2
      @pos_2.question_number.should == 3
      @pos_3.question_number.should == 1
    end
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
