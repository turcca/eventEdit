class ContentOutcome < Content
  has_many :chosen_outcomes, :dependent => :destroy
  has_many :secondary_chosen_outcomes, :dependent => :destroy
  
  def text_for_selecting_outcome
    select_text = '' + self.parent.text
    if self.equality1 == 'range'
      if !self.tool1.nil? && !self.tool1.tool.nil? && !self.equality1.blank? && !self.value1.blank? && !self.rangevalue.blank?
        select_text << ' ' + ApplicationHelper.toolstring(self.tool1) + ' ' + self.equality1 + ' ' + self.value1 + '-' + self.rangevalue
      end
    else  
      if !self.tool1.nil? && !self.tool1.tool.nil? && !self.equality1.blank? && !self.value1.blank?
        select_text << ' ' + ApplicationHelper.toolstring(self.tool1) + self.equality1 + self.value1
      end
      if !self.andor.blank? && !self.tool2.nil? && !self.tool2.tool.nil? && !self.equality2.blank? && !self.value2.blank?
        select_text << ' ' + self.andor + ' ' + ApplicationHelper.toolstring(self.tool2) + self.equality2 + self.value2
      end
    end
    return select_text
  end
end