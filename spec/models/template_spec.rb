require 'spec_helper'

describe Template do
  let(:valid_position) { Position.create(:title => "Ruby developer") }
  let(:stage_one) { valid_position.stage_at(1) }
  let(:valid_template) { Template.create(:name => "Advanced Ruby") }

  describe "validations" do
    it "should be valid with valid attributes" do
      valid_template.should be_valid
    end

    it "should have a name" do
      valid_template.name = nil
      valid_template.should_not be_valid
      valid_template.should have(1).error_on(:name)
    end
  end

  describe "#add_questions_from_stage" do
    before do
      stage_one.stage_questions.create(
          :question => "Explain to me meta-programming?",
          :answer => "Write code to write more code",
          :points => 10
      )

      stage_one.stage_questions.create(
          :question => "Who invented Rails?",
          :answer => "DHH",
          :points => 10
      )

      @template = Template.create(:name => "Advanced Ruby")
    end

    it "saves all questions in stage" do
      @template.add_questions_from_stage(stage_one)
      @template.questions.count.should == 2
    end
  end
end
