class ChosenTool < ActiveRecord::Base
  
  has_one :character_row, :class_name => 'Event', :foreign_key => 'character_tool_id'
  has_one :location_row, :class_name => 'Event', :foreign_key => 'location_tool_id'
  has_one :trigger_row, :class_name => 'Event', :foreign_key => 'trigger_tool_id'
  has_one :probability_tool1, :class_name => 'Probability', :foreign_key => 'tool1_id', :inverse_of => :tool1
  has_one :probability_tool2, :class_name => 'Probability', :foreign_key => 'tool2_id', :inverse_of => :tool2
  has_one :content_tool1, :class_name => 'Content', :foreign_key => 'tool1_id', :inverse_of => :tool1
  has_one :content_tool2, :class_name => 'Content', :foreign_key => 'tool2_id', :inverse_of => :tool2
  has_one :advice_tool, :class_name => 'AdviceContent', :foreign_key => 'tool_id', :inverse_of => :tool
  has_many :chosen_parameters, :dependent => :destroy
  belongs_to :tool
  belongs_to :pre_tool, :class_name => 'Tool'
  
  accepts_nested_attributes_for :chosen_parameters, :allow_destroy => true
  
  before_save :check_tool_for_pretool_and_depracated_tool_and_setup_chosen_parameters_and_setup_complete
  
  private
  
  def check_tool_for_pretool_and_depracated_tool_and_setup_chosen_parameters_and_setup_complete
    if !self.pre_tool.nil? && !self.pre_tool.is_pre_tool  # If the pre-tool is a tool, switch it to tool and clear pre-tool
      self.tool = self.pre_tool
      self.pre_tool = nil;
    end
    if !self.tool.nil?
      if self.tool.is_pre_tool  # If the first chosen tool was a pre-tool, switch it to pre-tool field
        self.pre_tool = self.tool
        self.tool = nil
      elsif !self.pre_tool.nil?
        if self.tool.pre_tools.find_by_id(self.pre_tool_id).nil?  # If the tool doesn't fit with the pre-tool, clear it
          self.tool = nil
        end
      elsif self.pre_tool.nil? && !self.tool.pre_tools.blank?  # If the pre-tool is empty and the tool is marked under a pre-tool, clear it
        self.tool = nil
      elsif !self.character_row.nil? && !self.tool.character  # If the tool is used in character row but it isn't allowed there, clear it
        self.tool = nil
      elsif !self.location_row.nil? && !self.tool.location  # If the tool is used in character row but it isn't allowed there, clear it
        self.tool = nil
      elsif !self.trigger_row.nil? && !self.tool.trigger  # If the tool is used in trigger row but it isn't allowed there, clear it
        self.tool = nil
      elsif !self.probability_tool1.nil? && !self.tool.probability  # If the tool is used in probability row but it isn't allowed there, clear it
        self.tool = nil
      elsif !self.probability_tool2.nil? && !self.tool.probability  # If the tool is used in probability row but it isn't allowed there, clear it
        self.tool = nil
      elsif !self.advice_tool.nil? && !self.tool.advice  # If the tool is used in advice row but it isn't allowed there, clear it
        self.tool = nil
      end
    end
  
    if !self.tool.nil?
      # Create the right number of chosen_parameters for the tool
      if chosen_parameters.count < tool.parameters.count
        (tool.parameters.count - chosen_parameters.count).times do
          chosen_parameters << ChosenParameter.new(:chosen_tool_id => self.id)
        end
      elsif chosen_parameters.count > tool.parameters.count
        chosen_parameters.last(chosen_parameters.count - tool.parameters.count).each do |parameter|
          parameter.mark_for_destruction
        end
      end
      
      # setup the parameter_id's for the chosen_parameters and clear parameter_values if they don't fit in the new parameter types
      chosen_parameters.each_with_index do |chosen_parameter, index|
        unless chosen_parameter.marked_for_destruction?
          chosen_parameter.parameter = tool.parameters.where("order_number = ?", index + 1).first
          if chosen_parameter.parameter_value && chosen_parameter.parameter_value.parameter_type != chosen_parameter.parameter.parameter_type
            chosen_parameter.parameter_value = nil
          elsif chosen_parameter.custom_value && !chosen_parameter.parameter_value.parameter_type.is_custom_type
            chosen_parameter.custom_value = ''
          end
        end
      end
      
    elsif !chosen_parameters.empty? # If there's no tool but there are still parameters, destroy them
      chosen_parameters.each do |parameter|
        parameter.mark_for_destruction
      end
    end
    
    # Mark the chosen_tool as complete if it's completely filled
    parameters_complete = true
    if !self.tool.nil? && 
      self.chosen_parameters.each do |chosen_parameter|
        unless chosen_parameter.marked_for_destruction?
          if chosen_parameter.parameter_value.blank? && chosen_parameter.custom_value.blank?
            parameters_complete = false
          end
        end
      end
      self.complete = parameters_complete
    else
      self.complete = false
    end
    
    true
  end
  
end
