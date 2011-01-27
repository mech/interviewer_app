class Response
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question_number, :type => Integer
  field :points,          :type => Integer, :default => 0
  field :answered,        :type => Boolean, :default => false

  index :question_number

  embedded_in :interview
  embeds_many :response_comments

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
    points > stage_question.points
  end
end
