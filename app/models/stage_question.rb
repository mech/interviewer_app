class StageQuestion
  include Mongoid::Document

  before_create :assign_question_number
  after_destroy :sort_questions

  field :question_number, :type => Integer
  field :points,          :type => Integer, :default => 0
  field :question,        :type => String
  field :answer,          :type => String
  field :category,        :type => String

  CATEGORIES = ["Open-ended", "Direct", "Technical", "Teamwork"]

  embedded_in :stage, :inverse_of => :stage_questions
  
  validates :question, :presence => true
  validates_numericality_of :points, :greater_than => 0

  def to_param
    question_number.to_s
  end

  protected

  def assign_question_number
    self.question_number = stage.stage_questions.count + 1
  end

  def sort_questions
    stage.sort_questions
  end
end
