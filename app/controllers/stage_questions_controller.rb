class StageQuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_position
  before_filter :find_stage

  def index
    if @stage
      @stage_questions = @stage.stage_questions

      if request.delete?
        @stage_questions.delete_all
        respond_with [@position, @stage]
      end
    end
  end

  def create
    if @stage
      @index = params[:stage_question][:index]
      @stage_question = @stage.stage_questions.build(params[:stage_question])
      @stage_question.save
      respond_with @stage_question
    end
  end

  def update
    if @stage
      @stage_question = @stage.stage_question_at(params[:id])
      @stage_question.update_attributes(params[:stage_question])
      respond_with @stage_question
    end
  end

  def sort
    @ordering_layout = params[:qn] # => ["2", "1", "3"]
    @stage.sort_questions(@ordering_layout)
    
    @stage_question = @stage.stage_questions.build unless @stage.locked? # ready for entry
  end

  def destroy
    # TODO - Check if we can delete question that is being used
    if @stage
      @stage_question = @stage.stage_question_at(params[:id])
      @stage_question.destroy
      
      @stage_question = @stage.stage_questions.build unless @stage.locked? # ready for entry
    end
  end

  private

  def find_position
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]
  end

  def find_stage
    @stage = @position.stage_at(params[:stage_id]) if @position
  end
end
