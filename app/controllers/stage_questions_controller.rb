class StageQuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_position
  before_filter :find_stage

  def create
    if @stage
      @index = params[:stage_question][:index]
      @stage_question = @stage.stage_questions.build(params[:stage_question])
      @stage_question.save
      respond_with @stage_question
    end
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end

  def find_stage
    @stage = @position.stage_at(params[:stage_id]) if @position
  end
end
