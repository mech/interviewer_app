class StageQuestion
  include Mongoid::Document

  before_create :assign_question_number

  field :question_number, :type => Integer, :default => 1
  field :points,          :type => Integer, :default => 0
  field :question,        :type => String
  field :answer,          :type => String
  field :category,        :type => String

  CATEGORIES = ["Open-ended", "Direct", "Technical", "Teamwork"]

  embedded_in :stage, :inverse_of => :questions
  
  validates :question, :presence => true

  protected

  def assign_question_number
    self.question_number = stage.questions.count + 1
  end
end
