# Store any pin for a particular stage
# Scope to user
# Limit to 10 pins per user
class PinStage
  include Mongoid::Document

#  validate :limit_pins_per_user
  validates_uniqueness_of :position_id, :scope => :stage_number

  field :user_id, :type => Integer
  field :stage_number, :type => Integer
  field :position_id, :type => BSON::ObjectId

  def position
    @position ||= Position.find position_id rescue nil
  end

  def position_title_with_stage
    "S#{stage_number}:#{position.title}"
  end

  def stage
    @stage ||= position.stage_at(stage_number)
  end

  # Pull the questions out from the template
  # and save it into the position stage
  # Overwrite any duplicate
  #
  # @param [Template] template
  # @return [Boolean] whether it has been saved or not
  def save_questions_from_template(template)
    return true if template.questions.empty?

    template.questions.each do |question|
      existing = stage.stage_questions.where(:template_question_id => question.id).limit(1).first

      if existing
        existing.update_attributes(:category => question.category, :question => question.question, :answer => question.answer, :points => question.points)
      else
        stage.stage_questions.create(:template_question_id => question.id, :category => question.category, :question => question.question, :answer => question.answer, :points => question.points)
      end
    end
  end
end
