class JobsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      redirect_to jobs_url, :notice => "Job has been created successfully."
    else
      render "new"
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
