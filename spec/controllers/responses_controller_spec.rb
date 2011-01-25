require 'spec_helper'

describe ResponsesController do
  render_views

  let(:position) { Position.create(title: "Ruby developer") }
  let(:stage_one) { position.stage_at(1) }

  before do
    stage_one.stage_questions.create(question: "a", answer: "b", points: 5)
    stage_one.stage_questions.create(question: "a", answer: "b", points: 5)
    @interview = position.interviews.create(
      candidate_name: "mech",
      candidate_email: "mech@me.com",
      where: "Tampines, Singapore",
      when: Date.today
  )
  end

  describe "POST 'create'" do
    it "assigns @question" do
      post :create, position_id: position.id, interview_id: @interview.id, question_id: 1, response: {response_comment: {comment: "Good answer!"}}
      assigns(:question).should be_true
    end

    it "saves comment to question 1" do
      post :create, position_id: position.id, interview_id: @interview.id, question_id: 1, response: {response_comment: {comment: "Good answer!"}}
      response.should redirect_to position_interview_question_path(position, @interview, 2)
    end
  end
end
