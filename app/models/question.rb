class Question
  include Mongoid::Document

  field :question,        :type => String
  field :answer,          :type => String
  field :points,          :type => Integer, :default => 0
  field :category,        :type => String

  embeds_many :notes # or comments?
  references_and_referenced_in_many :templates

  CATEGORIES = ["Open-ended", "Direct", "Technical", "Teamwork"]
end
