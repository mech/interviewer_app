class Job
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title,       :type => String
  field :status,      :type => String, :default => "open"
  field :description, :type => String
  field :location,    :type => String

  references_one :company

  validates_presence_of :title, :status, :company

  attr_protected :_id

  scope :open, where(:status => "open")
  scope :closed, where(:status => "closed")
end
