require 'spec_helper'

describe Interview do
  let(:position) { Position.create(:title => "Ruby developer") }
  let(:stage_one) { position.stage_at(1) }

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

    it "must not proceed to next stage if points insufficient" do
      # Stage one questions
      stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      stage_one.update_attributes(:points => 10)

      first_interview = position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com", :status => "completed")
      first_interview.responses.create(:question_number => 1, :points => 5)
      first_interview.responses.create(:question_number => 2, :points => 4)

      expect {
        interview = position.interviews.build(:candidate_name => "mech", :candidate_email => "mech@me.com")
        interview.save!
      }.to raise_error(Exceptions::PointsNotEnoughError)
    end
  end

  describe "interview status" do
    before do
      stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      stage_one.update_attributes(:points => 10)

      @first_interview = position.interviews.create(:candidate_name => "mech", :candidate_email => "mech@me.com")
      @first_interview.responses.create(:question_number => 1, :points => 5)
      @first_interview.responses.create(:question_number => 2, :points => 5)
    end

    it "updates interview status to completed when all questions have been answered" do
      @first_interview.should be_completed
    end
  end
end
