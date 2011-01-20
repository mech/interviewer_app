require 'spec_helper'

describe InterviewsController do
  render_views

  let(:position) { Position.create(:title => "Ruby developer") }

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :position_id => position.id
      response.should be_success
    end

    it "assigns @interview" do
      get 'new', :position_id => position.id
      assigns(:interview).should be_true
    end
  end

  describe "POST 'create'" do
    before do
      @stage_one = position.stage_at(1)
      @stage_two = position.stages.create
      @stage_three = position.stages.create

      # Stage one question
      @stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      @stage_one.stage_questions.create(:question => "a", :answer => "b", :points => 5)
      @stage_one.update_attributes(:points => 10)

      @valid_params = {
        :position_id => position.id,
        :interview => {
          :candidate_name => "mech",
          :candidate_email => "mech@me.com"
        }
      }
    end

    context "we have 3 stages" do
      it "position has 3 stages" do
        position.should have(3).stages
      end
    end

    context "first interview" do
      it "creates a new interview" do
        post :create, @valid_params
        assigns(:position).should have(1).interviews
      end
    end

    context "second interview" do
      before do
        @first_interview = position.interviews.create(@valid_params[:interview])
      end
      
      context "first interview has not finished" do
        it "first interview is pending" do
          @first_interview.should be_pending
        end

        it "redirect to first interview details page" do
          post :create, @valid_params
          flash[:alert].should == "There are pending interview."
          response.should redirect_to([position, @first_interview])
        end
      end

      context "first interview has finished" do
        before do
          @first_interview.update_attributes(:status => "completed")
        end

        it "first interview completed" do
          @first_interview.should be_completed
        end

        context "insufficient points" do

          it "raise insufficient points" do
            post :create, @valid_params
            flash[:alert].should == "Points not enough."
            response.should redirect_to([position, @first_interview])
          end
        end

        context "enough points" do

        end
      end
    end

    context "third interview" do

    end

    context "too many interviews" do

    end
  end
end
