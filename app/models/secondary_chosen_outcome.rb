class SecondaryChosenOutcome < ActiveRecord::Base
  belongs_to :secondary_prereq
  belongs_to :content_outcome
end
