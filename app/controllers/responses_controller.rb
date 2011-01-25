class ResponsesController < ApplicationController
  before_filter :find_interview, {only: [:create]}

  def create
    
  end

  protected

  def find_interview
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]

    if @position
      @interview = @position.interviews.find(params[:interview_id]) if params[:interview_id]
    end
  end
end
