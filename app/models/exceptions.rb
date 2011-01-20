module Exceptions
  class RepeatedStageNumberError < StandardError; end
  class RepeatedQuestionNumberError < StandardError; end
  class TooManyInterviewsError < StandardError; end
  class PendingInterviewError < StandardError; end
  class PointsNotEnoughError < StandardError; end
end
