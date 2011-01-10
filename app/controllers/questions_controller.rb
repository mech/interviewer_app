class QuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_template
  before_filter :find_question, :only => [:update, :destroy]

  def index
    
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
    @template = Template.find(params[:template_id])
  end

  def find_question
    @question = @template.questions.find(params[:id]) if @template
  end
end
