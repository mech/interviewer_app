class Job
  include Mongoid::Document
  
  field :title,       :type => String
  field :description, :type => String
  field :location,    :type => String

  validates_presence_of :title
end
