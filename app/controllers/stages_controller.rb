class StagesController < ApplicationController
  respond_to :html, :js, :json
  
  before_filter :find_position
  before_filter :find_stage

  def new
    @stage = @position.stages.build
    @next_stage_number = @position.stages.count + 1
  end

  def create
    @stage = @position.create_next_stage
    respond_with [@position, @stage]
  end

  # params[:id] will be referring to the stage position
  def show
    @stage_index = params[:id]
    @stage_question = @stage.stage_questions.build
    @template = Template.new
  end

  def update
    @stage.update_attributes(params[:stage])
    respond_with @stage
  end

  def save_as_templates
    @template = Template.new(params[:template])

    if @template.save
      @template.add_questions_from_stage(@stage)
    end
    
    respond_with @template
  end

  def pinned
    # TODO - Save the current user
    @pin_stage = PinStage.new(:position_id => @position.id, :stage_number => params[:stage_number])
    @pin_stage.save
  end

  def pull_questions
    # TODO - Scope to current user
    pin_stage = PinStage.find params[:pin_stage_id]
    template = Template.find params[:template_id]
    pin_stage.save_questions_from_template(template)
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end

  def find_stage
    @stage = @position.stage_at(params[:id])
  end
end
