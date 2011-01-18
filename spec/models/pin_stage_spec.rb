require 'spec_helper'

describe PinStage do
  describe "#save_questions_from_template" do
    before do
      @position = Position.create(:title => "Ruby developer")
      @template = Template.create(:name => "Mid-level Project Manager")
      @pin_stage = PinStage.create(:position_id => @position.id, :stage_number => @position.stage_at(1).stage_number)
      2.times do
        @template.questions << Question.new(:category => "Direct", :question => "test", :answer => "test", :points => 10)
      end
      @template.save
    end

    it "saves questions from template" do
      @pin_stage.save_questions_from_template(@template)
      @pin_stage.stage.stage_questions.count.should == 2
    end

    it "returns true if no question to save" do
      @empty_template = Template.create(:name => "No question")
      @pin_stage.save_questions_from_template(@empty_template).should be_true
    end
  end
end
