class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,        :type => String
  field :status,      :type => String, :default => "inactive"
  field :biz_reg_num, :type => String

  referenced_in :position
end
