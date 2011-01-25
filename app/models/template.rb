class Template
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,    :type => String, :default => "Untitled"
  field :public,  :type => Boolean, :default => false

  index :public
  # TODO - Score template to company? What about sharable template?

  validates :name, :presence => true

  references_and_referenced_in_many :questions

  # TODO - Move it to background processing
  def add_questions_from_stage(stage)
    stage.stage_questions.each do |question|
      questions << Question.new(
          :category => question.category,
          :question => question.question,
          :answer => question.answer,
          :points => question.points
      )
    end

    self.save
  end
end
