class Stage
  include Mongoid::Document

  field :stage_number,  :type => Integer, :default => 1
  field :points,        :type => Integer, :default => 0

  embedded_in :position, :inverse_of => :stages
  embed_many :questions, :class_name => "StageQuestion"

  # Get the maximum points a candidate can score
  def full_mark
    questions.sum(&:points)
  end
end
