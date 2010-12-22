require 'spec_helper'

describe Job do
  let(:valid_job) { Job.new(:title => "Ruby developer", :company => Company.new) }

  describe "valid job" do
    it "should be valid with valid attributes" do
      valid_job.should be_valid
    end
  end

  describe "invalid job" do
    it "should have a title" do
      valid_job.title = nil
      valid_job.should_not be_valid
      valid_job.should have(1).error_on(:title)
    end

    it "should have a status" do
      valid_job.status = nil
      valid_job.should_not be_valid
      valid_job.should have(1).error_on(:status)
    end

    it "should have a company" do
      valid_job.company = nil
      valid_job.should_not be_valid
      valid_job.should have(1).error_on(:company)
    end
  end

  it "location can be geocoded"
  
  context "closed job" do
    it "should not accept any more interview"
  end

  describe "#search" do
    it "should allow searching"
  end
  
  describe "#to_json" do
    it "should provide JSON representation"
  end
end
