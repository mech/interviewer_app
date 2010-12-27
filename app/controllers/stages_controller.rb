class StagesController < ApplicationController
  before_filter :find_position

  def new
    
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end
end
