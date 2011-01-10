class PositionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_position, :only => [:show, :edit, :update, :destroy]

  def index
    @positions = Position.order_by([:updated_at, :desc]).paginate(:page => params[:page])
    respond_with @positions
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(params[:position])

    flash[:notice] = "Position has been created successfully." if @position.save
    respond_with [@position, @position.stage_at(1)]
  end

  def update
    flash[:notice] = "#{@position.title} has been updated successfully." if @position.update_attributes(params[:position])
    respond_with @position, :location => positions_url
  end

  def destroy
    # TODO - if position involve in interview, do not delete it
    @position.destroy
    redirect_to positions_url, :notice => "#{@position.title} has been removed."
  end

  protected

  def find_position
    @position = Position.find(params[:id])
  end

end
