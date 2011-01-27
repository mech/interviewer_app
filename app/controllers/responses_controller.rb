class ResponsesController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_interview
  before_filter :find_question

  def create
    if @question
      @response = @interview.responses.where(question_number: @question.question_number).limit(1).first || @interview.responses.build(question_number: @question.question_number)
      @response.answered = true unless @response.answered?
      @response.points = @question.points if params[:commit] =~ /Award/
      @response.save

      @response.response_comments.create(params[:response][:response_comment])

      if @question.next_question
        redirect_to position_interview_question_path(@position, @interview, @question.next_question)
      else
        redirect_to [@position, @interview]
      end
    end
  end

  def update
    
  end

  protected

  def find_interview
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]

    if @position
      @interview = @position.interviews.find(params[:interview_id]) if params[:interview_id]
    end
  end

  def find_question
    if @interview
      @question = @interview.stage.stage_questions.where(question_number: params[:question_id]).limit(1).first if params[:question_id]
    end
  end
end
