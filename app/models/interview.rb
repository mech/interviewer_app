class Interview
  include Mongoid::Document

  before_create :assign_stage_number

  field :where,                   :type => String
  field :when,                    :type => DateTime
  field :candidate_email,         :type => String
  field :candidate_name,          :type => String
  field :candidate_linkedin_id,   :type => String
  field :stage_number,            :type => Integer
  field :points,                  :type => Integer, :default => 0

  referenced_in :position
  # embeds_many :responses # each stage correspond to 1 response
  # embeds_many :comments

  validates_presence_of :candidate_name, :candidate_email, :stage_number
  validates_uniqueness_of :candidate_email, :scope => :stage_number

  protected

  # We need to find out if this is the first interview and how
  # many stages the position has
  def assign_stage_number
    number_of_stages = position.stages.count
    position.interviews.where(:candidate_email => candidate_email).count
  end
end
