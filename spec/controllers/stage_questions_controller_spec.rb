require 'spec_helper'

describe StageQuestionsController do
  render_views

  describe "POST 'create'" do
    before do
      @valid_params = {
        :stage_question => {
          :question => "Explain to me meta-programming?",
          :answer => "Write code to write more code"
        }
      }
    end

    context "save as standalone question" do
      pending "save question not tied to job"
    end

    context "save with stage" do
      let(:valid_position) { Position.create(:title => "Ruby developer") }
      let(:valid_stage) { valid_position.stages.first }

      it "saves a new question" do
        lambda {
          xhr :post, 'create', @valid_params.merge({ :position_id => valid_position.id, :stage_id => valid_stage.stage_number }) 
        }.should change(StageQuestion, :count).by(1)
      end

      it "assigns @stage_question" do
        xhr :post, 'create', @valid_params
        assigns(:stage_question).should be_true
      end

      it "presents a new question form for next question sequence"
    end
  end
end
