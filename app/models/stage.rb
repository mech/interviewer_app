class Stage
  include Mongoid::Document

  field :position, :type => Integer

  embedded_in :job, :inverse_of => :jobs
end
