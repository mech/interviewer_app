class Stage
  include Mongoid::Document
  include Exceptions

  field :stage_number,  :type => Integer, :default => 1
  field :points,        :type => Integer, :default => 0
  field :lock,          :type => Boolean, :default => false

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

  def stage_question_at(number)
    return nil if number.blank?
    _stage_questions = stage_questions.where(:question_number => number).limit(2) # 2 is enough for us to determine duplication

    if _stage_questions.count > 1
      # TODO - Do internal fixing, self-heal
      raise RepeatedQuestionNumberError
    else
      _stage_questions.first
    end
  end
end
