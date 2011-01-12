# Store any pin for a particular stage
# Scope to user
# Limit to 10 pins per user
class PinStage
  include Mongoid::Document

  validate :limit_pins_per_user

  field :user_id, :type => Integer
  field :stage_number, :type => Integer

  references_one :position

  protected
  
  def limit_pins_per_user
  end
end
