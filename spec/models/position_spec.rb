require 'spec_helper'

describe Position do
  let(:valid_position) { Position.create(:title => "Ruby developer") }

  describe "validations" do
    it "should be valid with valid attributes" do
      valid_position.should be_valid
    end

    it "should have stage number one automatically" do
      valid_position.should have(1).stages
    end
    
    it "should have a title" do
      valid_position.title = nil
      valid_position.should_not be_valid
      valid_position.should have(1).error_on(:title)
    end

    it "should have a status" do
      valid_position.status = nil
      valid_position.should_not be_valid
      valid_position.should have(1).error_on(:status)
    end

    it "should have a company" do
      pending("For company spec completion")
      valid_position.company = nil
      valid_position.should_not be_valid
      valid_position.should have(1).error_on(:company)
    end
  end

  context "closed position" do
    it "refuses any more interviews"
  end

  describe "#search" do
    it "allows searching"
  end

  describe "#stage_at" do
    before do
      @stage_one = valid_position.stages.first
      @stage_dup = valid_position.stages.create(:stage_number => 1, :points => 20)
      @stage_dup.stage_number = 1
      @stage_dup.save!
    end

    it "accepts one Integer argument" do
      lambda {
        valid_position.stage_at
      }.should raise_exception(ArgumentError)
    end

    it "returns nil if position argument is nil" do
      valid_position.stage_at(nil).should be_nil
    end

    it "raises RepeatedStageNumberError when finding more than one record" do
      lambda {
        valid_position.stage_at(1)
      }.should raise_exception(Exceptions::RepeatedStageNumberError)
    end
  end

  describe "#create_next_stage" do
    it "saves a new stage" do
      lambda {
        valid_position.create_next_stage
      }.should change(valid_position.stages, :count).by(1)
    end
  end
end
