require 'spec_helper'

describe QuestionsController do
  render_views

  describe "POST 'create'" do
    before do
      @valid_params = {
        :question => {
          :question => "What is Agile?",
          :answer => "Delivering software that matters",
          :points => 10
        }
      }
    end

    context "save with template" do
      let(:valid_template) { Template.create(:name=> "Mid-level Project Manager") }

      it "saves a new question" do
        expect {
          xhr :post, 'create', @valid_params.merge({ :template_id => valid_template.id })
        }.to change {
          valid_template.reload.question_ids.count
        }.by(1)
      end

      it "assigns @question" do
        xhr :post, 'create', @valid_params.merge({ :template_id => valid_template.id })
        assigns(:question).should be_true
      end
    end
  end
end
