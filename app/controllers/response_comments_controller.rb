class ResponseCommentsController < ApplicationController
  respond_to :html, :js, :json
  
  before_filter :find_interview
  before_filter :find_response

  def create
    if @response
      @comment = @response.response_comments.create(params[:response_comment])
      redirect_to position_interview_question_path(@position, @interview, params[:question_id])
    end
  end

  protected

  def find_interview
    # TODO - Scope to company
    @position = Position.find(params[:position_id]) if params[:position_id]

    if @position
      @interview = @position.interviews.find(params[:interview_id]) if params[:interview_id]
    end
  end

  def find_response
    if @interview
      @response = @interview.responses.find(params[:response_id])
    end
  end
end
