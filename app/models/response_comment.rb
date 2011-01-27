class ResponseComment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :comment, :type => String
  # TODO - who commented on it

  embedded_in :response

  validates_presence_of :comment
end
