class ChosenParameter < ActiveRecord::Base
  
  belongs_to :chosen_tool
  belongs_to :parameter_value
  belongs_to :parameter
  
end
