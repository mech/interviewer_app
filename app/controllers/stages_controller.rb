class StagesController < ApplicationController
  before_filter :find_position

  def new
    @stage = Stage.new
  end

  # params[:id] will be referring to the stage position
  def show
    @stage_index = params[:id]
    @question = @position.stages.build
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end
end
