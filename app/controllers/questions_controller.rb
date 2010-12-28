# QuestionsController serves 2 purposes:
#   1. To setup question for a particular job's stage
#   2. To setup standalone question to be stored as template
#
# If we do not detect any stage, we will assume it is standalone question.
#
# @author mech
class QuestionsController < ApplicationController
  respond_to :html, :js, :json

  before_filter :find_position
  before_filter :find_stage

  def create
    if @stage
      @question = @stage.questions.build(params[:question])
      @question.save
      respond_with @question
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
