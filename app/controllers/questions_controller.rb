class QuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_template
  before_filter :find_question, {only: [:update, :destroy]}
  before_filter :find_interview, {only: [:show]}

  def index
    
  end

  def show
    if @interview
      @question = @interview.stage.stage_questions.where(question_number: params[:id]).limit(1).first
      @response = @interview.responses.where(question_number: params[:id]).limit(1).first || @interview.responses.build(question_number: params[:id])
      @response_comment = @response.response_comments.build
    else
      # normal template question
    end
  end

  def create
    @question = Question.new(params[:question])
    @template.questions << @question
    @template.save
    respond_with @question
  end

  def update
    @index = params[:question][:index]
    @question.update_attributes(params[:question])
    respond_with @question
  end

  def destroy
    # TODO - Check if we can delete question that is being used
    @question.destroy
    @template.reload # Strange, or else question will not be removed at view, but not StageQuestion impl
    @question = @template.questions.build # ready for entry
  end

  protected

  def find_template
    @template = Template.find(params[:template_id]) if params[:template_id]
  end

  def find_question
    @question = @template.questions.find(params[:id]) if @template
  end

  def find_interview
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]

    if @position
      @interview = @position.interviews.find(params[:interview_id]) if params[:interview_id]
    end
  end
end
