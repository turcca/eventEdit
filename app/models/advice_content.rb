class AdviceContent < ActiveRecord::Base
  has_ancestry
  
  TEMPLATES = ['Ideology', 'Skill 2', 'Skill 3']
  
  validates :condition, :inclusion => Probability::CONDITIONS, :allow_blank => true
  validates :equality, :inclusion => Probability::EQUALITY_MARKERS_WITH_RANGE, :allow_blank => true
  
  belongs_to :tool, :class_name => "ChosenTool", :inverse_of => :advice_tool, :dependent => :destroy
  
  accepts_nested_attributes_for :tool, :allow_destroy => true
  
  before_save :clear_fields
  
  attr_accessor :template
  
  private
  
  def clear_fields
    unless self.new_record?
      if self.condition.blank?
        unless tool.nil?
          self.tool.tool = nil
          self.tool.pre_tool = nil
          self.tool.save
        end
        self.equality = nil
        self.value = nil
      elsif self.tool.tool && self.tool.tool.booleanreturn
        self.equality = nil
        self.value = nil
      end
    end
  end
  
end
