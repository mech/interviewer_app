class Stage
  include Mongoid::Document

  field :position, :type => Integer

  embedded_in :position, :inverse_of => :positions
end
