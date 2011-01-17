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
end
