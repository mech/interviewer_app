require 'spec_helper'

describe Position do
  let(:valid_position) { Position.new(:title => "Ruby developer", :company => Company.new) }

  describe "valid position" do
    it "should be valid with valid attributes" do
      valid_position.should be_valid
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

  it "location can be geocoded"

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
