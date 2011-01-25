class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question,        :type => String
  field :answer,          :type => String
  field :points,          :type => Integer, :default => 0
  field :category,        :type => String

  index :category

  embeds_many :notes # or comments?
  references_and_referenced_in_many :templates

  validates :question, :presence => true
  validates_numericality_of :points, :greater_than => 0

  CATEGORIES = ["Open-ended", "Direct", "Technical", "Teamwork"]
end
