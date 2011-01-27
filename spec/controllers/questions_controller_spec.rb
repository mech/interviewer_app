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

  describe "POST 'update'" do
    let(:valid_template) { Template.create(:name=> "Mid-level Project Manager") }
    let(:valid_question) {
      qn = Question.new(
          :question => "What is Agile?",
          :answer => "Delivering software that matters",
          :points => 10
      )
      
      valid_template.questions << qn
      valid_template.save
      qn
    }

    it "updates question" do
      @params = {
        :index => 1,
        :question => "modified"
      }
      xhr :post, 'update', :template_id => valid_template.id, :id => valid_question.id, :question => @params
    end
  end

  describe "GET 'show'" do
    context "with interview" do
      it "shows stage question" do
      end
    end
  end
end
