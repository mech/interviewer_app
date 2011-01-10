class TemplatesController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_template, :only => [:show, :edit, :update, :destroy]

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
    @question = @template.questions.build
  end

  protected

  def find_template
    @template = Template.find(params[:id])
  end
end
