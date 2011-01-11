class Template
  include Mongoid::Document

  field :name, :type => String
  # TODO - Score template to company? What about sharable template?

  validates :name, :presence => true

  references_and_referenced_in_many :questions
end
