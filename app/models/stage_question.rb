class StageQuestion
  include Mongoid::Document
  include Mongoid::Timestamps

  before_create :assign_question_number
  after_destroy :sort_questions

  field :question_number, :type => Integer
  field :points,          :type => Integer, :default => 0
  field :question,        :type => String
  field :answer,          :type => String
  field :category,        :type => String
  # field :locked,          :type => Boolean, :default => false

  index :question_number
  index :category

  # TODO - who have to know who asked what question and who is responsible
  # Not sure if this referencing works as we are in embedded document and user is another root document
  # referenced_in :user

  embedded_in :stage
  referenced_in :template_question, :class_name => "Question"
  
  validates :question, :presence => true
  validates_numericality_of :points, :greater_than => 0

  def to_param
    question_number.to_s
  end

  def previous_question
    previous_question_number = question_number.pred
    stage.stage_questions.where(question_number: previous_question_number).limit(1).first
  end

  def next_question
    next_question_number = question_number.succ
    stage.stage_questions.where(question_number: next_question_number).limit(1).first
  end

  protected

  def assign_question_number
    self.question_number = stage.stage_questions.count + 1
  end

  def sort_questions
    stage.sort_questions
  end
end
