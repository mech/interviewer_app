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
    redirect_to jobs_url, :notice => "Job has been created successfully"
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
