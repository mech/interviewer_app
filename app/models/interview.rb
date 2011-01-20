class Interview
  include Mongoid::Document
  include Exceptions

  before_create :assign_stage_number
  before_create :check_pending_interviews
  before_create :check_enough_points

  field :where,                   :type => String
  field :when,                    :type => DateTime
  field :candidate_email,         :type => String
  field :candidate_name,          :type => String
  field :candidate_linkedin_id,   :type => String
  field :stage_number,            :type => Integer
  field :status,                  :type => String, :default => "pending"

  referenced_in :position
  # embeds_many :responses # each stage correspond to 1 response
  # embeds_many :comments

  validates_presence_of :candidate_name, :candidate_email
  validates_uniqueness_of :candidate_email, :scope => :stage_number

  scope :pending, lambda { |email| where(:candidate_email => email, :status => "pending") }

  %w(pending completed).each do |s|
    define_method "#{s}?" do
      self.status == s
    end
  end

  # The corresponding stage this interview is tied to
  #
  # @return [Stage, nil]
  def stage
    return nil if stage_number.blank?

    @stage ||= position.stage_at(stage_number)
  end

  def points
    9
  end

  def failed?
    points < stage.points
  end

  def last_completed_interview
    position.interviews.where(:candidate_email => candidate_email, :status => "completed").order_by([:stage_number, :desc]).limit(1).first
  end

  protected

  # We need to find out if this is the first interview and how
  # many stages the position has
  def assign_stage_number
    stages_count = position.stages.count
    interviews_count = position.interviews.where(:candidate_email => candidate_email).count

    if interviews_count >= stages_count
      # errors.add(:stage_number, "too many interviews")
      raise TooManyInterviewsError
    else
      self.stage_number = interviews_count + 1
    end
  end

  def check_pending_interviews
    pending_interviews_count = position.interviews.pending(candidate_email).count
    raise PendingInterviewError unless pending_interviews_count.zero?
  end

  def check_enough_points
    if last_completed_interview
      raise PointsNotEnoughError if last_completed_interview.failed?
    end
  end
end
