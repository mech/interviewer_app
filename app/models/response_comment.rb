class ResponseComment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :response

  field :comment, :type => String

  # TODO - who commented on it
end
