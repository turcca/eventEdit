class ChosenFilter < ActiveRecord::Base
  belongs_to :event, :inverse_of => :chosen_filters
  belongs_to :filter, :inverse_of => :chosen_filters
  
  after_destroy :update_color_and_name_in_event
  
  def update_color_and_name_in_event
    self.event.save
  end
  
end
