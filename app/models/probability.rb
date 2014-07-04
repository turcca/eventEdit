class Probability < ActiveRecord::Base
  
  CONDITIONS = ['if']
  EQUALITY_MARKERS = ['<', '<=', '=', '>=', '>', 'NOT']
  EQUALITY_MARKERS_WITH_RANGE = ['<', '<=', '=', '>=', '>', 'NOT', 'range']
  ANDOR = ['AND', 'OR']
  
  validates :p, :presence => true
  validates :condition, :inclusion => CONDITIONS, :allow_blank => true
  validates :equality1, :inclusion => EQUALITY_MARKERS_WITH_RANGE, :allow_blank => true
  validates :equality2, :inclusion => EQUALITY_MARKERS, :allow_blank => true
  validates :andor, :inclusion => ANDOR, :allow_blank => true
  belongs_to :event
  belongs_to :tool1, :class_name => "ChosenTool", :inverse_of => :probability_tool1, :dependent => :destroy
  belongs_to :tool2, :class_name => "ChosenTool", :inverse_of => :probability_tool2, :dependent => :destroy
  
  accepts_nested_attributes_for :tool1, :allow_destroy => true
  accepts_nested_attributes_for :tool2, :allow_destroy => true
  
  before_save :clear_fields
  
  private
  
  def clear_fields
    unless self.new_record?
      if self.condition.blank?
        unless tool1.nil?
          self.tool1.tool = nil
          self.tool1.pre_tool = nil
          self.tool1.save
        end
        unless tool2.nil?
          self.tool2.tool = nil
          self.tool2.pre_tool = nil
          self.tool2.save
        end
        self.equality1 = nil
        self.equality2 = nil
        self.value1 = nil
        self.value2 = nil
        self.andor = nil
        self.rangevalue = nil
      else
        if self.tool1.tool && self.tool1.tool.booleanreturn
          self.equality1 = nil
          self.value1 = nil
        end
        if self.tool2.tool && self.tool2.tool.booleanreturn
          self.equality2 = nil
          self.value2 = nil
        end
        if self.equality1 == 'range'
          unless tool2.nil?
            self.tool2.tool = nil
            self.tool2.pre_tool = nil
            self.tool2.save
          end
          self.equality2 = nil
          self.value2 = nil
          self.andor = nil
        elsif self.andor.blank?
          unless tool2.nil?
            self.tool2.tool = nil
            self.tool2.pre_tool = nil
            self.tool2.save
          end
          self.equality2 = nil
          self.value2 = nil
        end
      end
      if self.equality1 != 'range'
        self.rangevalue = nil
      end
    end
  end
  
end
