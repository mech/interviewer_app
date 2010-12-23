class JobsController < ApplicationController
  respond_to :html, :js, :json

  def index
    @jobs = Job.order_by([:updated_at, :desc]).paginate
    respond_with @jobs
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      flash[:notice] = "Job has been created successfully."
    end
    
    respond_with @job, :location => jobs_url
  end

  def edit
  end

  def update
    redirect_to :action => index
  end

  def destroy
  end

end
