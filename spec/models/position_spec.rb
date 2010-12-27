require 'spec_helper'

describe Position do
  let(:valid_position) { Position.create(:title => "Ruby developer") }

  describe "valid position" do
    it "should be valid with valid attributes" do
      valid_position.should be_valid
    end

    it "should have stage number one automatically" do
      valid_position.should have(1).stages
    end
  end

  describe "invalid position" do
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
    it "should not accept any more interview"
  end

  describe "#search" do
    it "should allow searching"
  end

  describe "#to_json" do
    it "should provide JSON representation"
  end
end
