class Filter < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :chosen_filters, :inverse_of => :filter, :dependent => :destroy
  
  after_save :update_colors_in_events
  after_destroy :update_colors_in_events
  
  def update_colors_in_events
    Event.all.each do |event|
      event.save
    end
  end
  
end
