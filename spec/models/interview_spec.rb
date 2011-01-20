require 'spec_helper'

describe Interview do
  let(:position) { Position.create(:title => "Ruby developer") }

  before do
    position.create_next_stage
  end
  
  context "arrange interview for candidate" do
    it "assigns stage number incrementally" do
      int_one = position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com", :status => "completed")
      int_two = position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com")

      int_one.stage_number.should == 1
      int_two.stage_number.should == 2
    end

    it "must not exceed the number of stages a position has" do
      position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com", :status => "completed")
      position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com", :status => "completed")
      expect {
        interview = position.interviews.build(:candidate_name => "mech", :candidate_email => "mech@me.com")
        interview.save!
      }.to raise_error(Exceptions::TooManyInterviewsError)
    end

    it "must not proceed to next stage if there are pending interviews" do
      position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com", :status => "pending")
      expect {
        interview = position.interviews.build(:candidate_name => "mech", :candidate_email => "mech@me.com")
        interview.save!
      }.to raise_error(Exceptions::PendingInterviewError)
    end

    it "must not proceed to next stage if points insufficient"
  end
end
