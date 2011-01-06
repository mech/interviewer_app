class StagesController < ApplicationController
  respond_to :html, :js, :json
  
  before_filter :find_position
  before_filter :find_stage

  def new
    @stage = @position.stages.build
    @next_stage_number = @position.stages.count + 1
  end

  def create
    @stage = @position.stages.create(:points => 0, :stage_number => 1)
    respond_with [@position, @stage]
  end

  # params[:id] will be referring to the stage position
  def show
    @stage_index = params[:id]
    @stage_question = @stage.stage_questions.build
  end

  def update
    @stage.update_attributes(params[:stage])
    respond_with @stage
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
