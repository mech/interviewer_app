class Position
  include Mongoid::Document
  include Mongoid::Timestamps
  include Exceptions

  before_create :create_stage_one
  
  field :title,       :type => String
  field :status,      :type => String, :default => "open"
  field :description, :type => String
  field :location,    :type => String
  field :salary,      :type => BigDecimal
  
  references_one :company
  embeds_many :stages
  references_many :interviews

  validates_presence_of :title, :status#, :company

  attr_protected :_id

  scope :open, where(:status => "open")
  scope :closed, where(:status => "closed")

  # Get back the stage of the interview by numbered position
  # Ideally we would want @position.stages[0], but better don't overwrite it
  #
  # @param [Integer] position
  # @return [Stage, nil] the stage at this position
  def stage_at(position)
    return nil if position.blank?
    _stages = stages.where(:stage_number => position).limit(2) # 2 is enough for us to determine duplication

    if _stages.count > 1
      # TODO - Do internal fixing, self-heal 
      raise RepeatedStageNumberError
    else
      _stages.first
    end
  end

  def create_next_stage
    stages.create
  end

  protected

  def create_stage_one
    self.stages.build(:points => 0, :stage_number => 1)
  end
end
