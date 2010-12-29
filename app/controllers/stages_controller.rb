class StagesController < ApplicationController
  before_filter :find_position
  before_filter :find_stage

  def new
    @stage = Stage.new
  end

  # params[:id] will be referring to the stage position
  def show
    @stage_index = params[:id]
    @stage_question = @stage.stage_questions.build
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end

  def find_stage
    @stage = @position.stage_at(params[:id])
  end
end
