class TemplatesController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_template, :only => [:show, :edit, :update, :destroy]

  def browse
    # TODO - List view has 10 records and icon view has 8 records
    if params[:new_pin] == "yes"
      @new_pin = true
      params.delete(:new_pin) # remove it so that pagination will not show drawer repetitively
    end

    @templates = Template.paginate(:page => params[:page], :per_page => 8)
  end

  def index
    @templates = Template.paginate(:page => params[:page])
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(params[:template])
    flash[:notice] = "Template has been created successfully." if @template.save
    respond_with @template
  end

  def show
    @question = @template.questions.build unless request.xhr?
    respond_with @template
  end

  protected

  def find_template
    @template = Template.find(params[:id])
  end
end
