class Stage
  include Mongoid::Document

  field :points, :type => Integer, :default => 0

  embedded_in :position, :inverse_of => :stages
  embed_many :questions, :class_name => "StageQuestion"
end
