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
  embed_many :stages

  validates_presence_of :title, :status#, :company

  attr_protected :_id

  scope :open, where(:status => "open")
  scope :closed, where(:status => "closed")

  protected

  def stage_one
    self.stages.build(:points => 0)
  end
end
