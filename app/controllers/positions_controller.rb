class PositionsController < ApplicationController
  respond_to :html, :js, :json

  def index
    @positions = Position.order_by([:updated_at, :desc]).paginate
    respond_with @positions
  end

  def show
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(params[:position])

    if @position.save
      flash[:notice] = "Position has been created successfully."
      respond_with @position, :location => position_stage_url(@position, 1)
    else
      respond_with @position
    end


  end

  def edit
  end

  def update
    redirect_to :action => index
  end

  def destroy
  end

end
