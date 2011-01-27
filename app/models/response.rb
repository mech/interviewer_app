class Response
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :update_interview_status

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
    points >= stage_question.points
  end

  def failed?
    !passed?
  end

  protected

  def update_interview_status
    questions_count = stage.stage_questions.count
    answers_count = interview.responses.count

    interview.update_attributes(:status => "completed") if answers_count >= questions_count
  end
end
