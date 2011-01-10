class QuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_template

  def index
    
  end

  def create
    @question = Question.new(params[:question])
    @template.questions << @question
    @template.save
    respond_with @question
  end

  protected

  def find_template
    @template = Template.find(params[:template_id])
  end
end
