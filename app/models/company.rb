class Company
  include Mongoid::Document

  field :name,       :type => String
  field :status,     :type => String, :default => "inactive"

  referenced_in :job
end
