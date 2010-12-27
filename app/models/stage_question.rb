class StageQuestion
  include Mongoid::Document

  field :question_number, :type => Integer, :default => 1
  field :question,        :type => String
  field :answer,          :type => String

  embedded_in :stage, :inverse_of => :questions
end
