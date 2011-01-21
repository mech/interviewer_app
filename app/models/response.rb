class Response
  include Mongoid::Document

  field :question_number, :type => Integer
  field :points,          :type => Integer

  embedded_in :interview
  # embeds_many :comments, :class_name => ResponseComment

  validates_presence_of :question_number
  validates_uniqueness_of :question_number, :scope => :interview

  def stage
    @stage ||= interview.stage
  end

  def stage_question
    @stage_question ||= interview.stage.stage_question_at(question_number)
  end

  def passed?
    !failed?
  end

  def failed?
  end
end
