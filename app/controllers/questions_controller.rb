class QuestionsController < ApplicationController
  before_filter :find_position
  before_filter :find_stage

  def create
    
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
