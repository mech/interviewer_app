class Position
  include Mongoid::Document
  include Mongoid::Timestamps

  before_create :stage_one
  
  field :title,       :type => String
  field :status,      :type => String, :default => "open"
  field :description, :type => String
  field :location,    :type => String
  field :salary,      :type => BigDecimal

  references_one :company
  embeds_many :stages

  validates_presence_of :title, :status#, :company

  attr_protected :_id

  scope :open, where(:status => "open")
  scope :closed, where(:status => "closed")

  # Return the stage at the position specified
  #
  # @param [Integer] position
  # @return [Stage, nil] the stage at this position
  def stage_at(position)
    return nil if position.blank?
    stages.where(:stage_number => position).limit(1).first
  end

  protected

  def stage_one
    self.stages.build(:points => 0, :stage_number => 1)
  end
end
