require 'spec_helper'

describe QuestionsController do
  render_views

  describe "POST 'create'" do
    before do
      @valid_params = {
        :question => {
          :question => "Explain to me meta-programming?",
          :answer => "Write code to write more code"
        }
      }
    end

    context "save as standalone question" do
      pending "save question not tied to job"
    end

    context "save with stage" do
      it "saves a new question" do
        lambda {
          xhr :post, 'create', @valid_params
        }.should change(StageQuestion, :count).by(1)
      end

      it "assigns @question" do
        xhr :post, 'create', @valid_params
        assigns(:question).should be_true
      end

      it "presents a new question form for next question sequence"
    end
  end
end
