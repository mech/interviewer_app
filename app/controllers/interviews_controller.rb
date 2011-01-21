class InterviewsController < ApplicationController
  include Exceptions
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

    begin
      if @interview.save!
        flash[:notice] = "Interview has been created successfully."
        respond_with @interview, :location => [@position, @interview]
      end
    rescue TooManyInterviewsError
      flash[:alert] = "No stage to proceed next."
      redirect_to [@position, @interview.last_completed_interview]
    rescue PendingInterviewError
      flash[:alert] = "There are pending interview."
      @pending_interview = @position.interviews.pending(@interview.candidate_email).limit(1).first
      redirect_to [@position, @pending_interview]
    rescue PointsNotEnoughError
      flash[:alert] = "Points not enough."
      redirect_to [@position, @interview.last_completed_interview]
    end
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
