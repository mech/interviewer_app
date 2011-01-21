class Stage
  include Mongoid::Document
  include Exceptions

  before_create :assign_stage_number
  before_validation :limit_points
  validate :check_points_exceeded

  field :stage_number,  :type => Integer, :default => 1
  field :points,        :type => Integer, :default => 0 # Entry requirement points or veto?
  field :locked,        :type => Boolean, :default => false

  embedded_in :position
  embeds_many :stage_questions

  validates_numericality_of :points

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

  # Return the stage question at that question number
  # Raise RepeatedQuestionNumberError if more than 1 question with the same number
  #
  # @param [Integer] number
  # @return [StageQuestion]
  def stage_question_at(number)
    return nil if number.blank?
    _stage_questions = stage_questions.where(:question_number => number).limit(2) # 2 is enough for us to determine duplication

    if _stage_questions.count > 1
      sort_questions # Self-heal, we know there is repeated error, we fixed it
      raise RepeatedQuestionNumberError
    else
      _stage_questions.first
    end
  end

  # Sort question number according to the layout given
  # Layout has to be an array of question number
  #
  # @param [Array<Integer|String>] ordering_layout
  # @return [Boolean]
  def sort_questions(ordering_layout=[])
    if ordering_layout.blank?
      ordered_stage_questions.each_with_index do |question, index|
        question.question_number = index + 1
      end

      self.save
    else
      ordering_layout = ordering_layout.map(&:to_i)
      ordering_layout.delete(ordered_stage_questions.size + 1)
      
      ordered_stage_questions.each do |question|
        question.question_number = ordering_layout.find_index(question.question_number) + 1
      end

      self.save
    end
  end

  protected

  def limit_points
    return unless points.is_a?(Numeric)
    self.points = full_mark if points > full_mark
  end

  def check_points_exceeded
    errors.add :points, "can't exceed total question points" if points.is_a?(Numeric) && points > full_mark
  end

  def assign_stage_number
    # TODO - Do sequence check
    # Ask yourself if stage can be removed or not. If yes, then we need to be in sync
    self.stage_number = position.stages.count + 1
  end
end
