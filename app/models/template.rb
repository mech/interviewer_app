class Template
  include Mongoid::Document

  field :name, :type => String

  validates :name, :presence => true

  references_and_referenced_in_many :questions
end
