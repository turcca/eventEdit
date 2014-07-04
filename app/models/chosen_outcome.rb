class ChosenOutcome < ActiveRecord::Base
  belongs_to :event
  belongs_to :content_outcome
end
