class InterviewsController < ApplicationController
  respond_to :html, :js, :json
  
  before_filter :find_position

  def new
    @interview = @position.interviews.build
  end

  def create
    # TODO - check that number of interviews do not exceed number of stages
    # You do not want to create a new interview session when it exceed the number of stages
    # Subsequent interview other than the first one can be auto-created with enough points from previous
    # interview
    @interview = @position.interviews.build(params[:interview])

    flash[:notice] = "Interview has been created successfully." if @interview.save
    respond_with @interview, :location => [@position, @interview]
  end

  def show
    @interview = @position.interviews.find(params[:id])
  end

  protected

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end
end
