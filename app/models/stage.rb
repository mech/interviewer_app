class Stage
  include Mongoid::Document

  field :stage_number,  :type => Integer, :default => 1
  field :points,        :type => Integer, :default => 0

  embedded_in :position, :inverse_of => :stages
  embeds_many :stage_questions

  def ordered_stage_questions
    stage_questions.order_by(:question_number.asc)
  end

  # Get the maximum points a candidate can score
  def full_mark
    stage_questions.sum(&:points)
  end

  def to_param
    stage_number.to_s
  end
end
