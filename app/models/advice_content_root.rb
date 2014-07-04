class AdviceContentRoot < AdviceContent
  belongs_to :captain, :class_name => "Event", :inverse_of => :captain_root
  belongs_to :navigator, :class_name => "Event", :inverse_of => :navigator_root
  belongs_to :engineer, :class_name => "Event", :inverse_of => :engineer_root
  belongs_to :quartermaster, :class_name => "Event", :inverse_of => :quartermaster_root
  belongs_to :security, :class_name => "Event", :inverse_of => :security_root
  belongs_to :priest, :class_name => "Event", :inverse_of => :priest_root
  belongs_to :psycher, :class_name => "Event", :inverse_of => :psycher_root
  
  def event
    unless captain.nil?
      event = captain
    end
    unless navigator.nil?
      event = navigator
    end
    unless engineer.nil?
      event = engineer
    end
    unless quartermaster.nil?
      event = quartermaster
    end
    unless security.nil?
      event = security
    end
    unless priest.nil?
      event = priest
    end
    unless psycher.nil?
      event = psycher
    end
    return event
  end
  
end