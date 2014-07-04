class Tool < ActiveRecord::Base
  default_scope -> { order('name') }
  
  TOOL_TYPES = ['method', 'variable', 'other']
  
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => [:tooltype]
  validates :tooltype, :inclusion => TOOL_TYPES
  validate :parameters_only_in_methods
  validate :pre_tools_cant_have_pre_tools
  validate :pre_tools_must_be_variables
  
  has_many :parameters, :dependent => :destroy
  has_many :pre_tool_associations, :dependent => :destroy
  has_many :tool_associations, :class_name => 'PreToolAssociation', :foreign_key => 'pre_tool_id', :dependent => :destroy
  has_many :tools, :through => :pre_tool_associations, :dependent => :destroy
  has_many :pre_tools, :through => :pre_tool_associations, :dependent => :destroy
  has_many :chosen_tools, :dependent => :destroy
  has_many :chosen_pre_tools, :class_name => 'ChosenTool', :foreign_key => 'pre_tool_id', :dependent => :destroy
  
  accepts_nested_attributes_for :parameters, :allow_destroy => true
  accepts_nested_attributes_for :pre_tool_associations, :allow_destroy => true
  
  before_save :mark_pre_tool_associations_for_removal
  before_save :mark_parameters_for_removal
  after_save :handle_parameter_order_numbers

  private
  
  def mark_pre_tool_associations_for_removal
    pre_tool_associations.each do |pre_tool_assoc|
      pre_tool_assoc.mark_for_destruction if pre_tool_assoc.enabled == '0'
    end
  end
  
  def mark_parameters_for_removal
    parameters.each do |parameter|
      parameter.mark_for_destruction if parameter.parameter_type_id.blank?
    end
  end
  
  def parameters_only_in_methods
    error = false
    if tooltype != 'method'
      parameters.each do |parameter|
        if parameter.parameter_type_id.present?
          error = true
        end
      end
      if error
        errors.add(:parameters, "can only be used in methods")
      end
    end
  end
  
  def pre_tools_cant_have_pre_tools
    error = false
    if is_pre_tool
      pre_tool_associations.each do |pre_tool_assoc|
        if pre_tool_assoc.enabled == '1' && pre_tool_assoc.tool_id == id
          error = true
        end
      end
    end
    if error
      errors.add(:is_pre_tool, "and can't have pre-tools")
    end
  end
  
  def pre_tools_must_be_variables
    errors.add(:is_pre_tool, "so must be a variable") unless !self.is_pre_tool || self.tooltype == 'variable' 
  end
  
  def handle_parameter_order_numbers
    unless parameters.blank?
      if parameters.first.order_number != 1
        parameters.first.order_number = 1
        needs_saving = true
      end
      parameters.each_with_index do |parameter, index|
        if parameters[index + 1] && parameters[index + 1].order_number - parameter.order_number != 1
          parameters[index + 1].order_number = parameter.order_number + 1
          needs_saving = true
        end
      end
      if needs_saving
        parameters.each do |parameter|
          parameter.save
        end
      end
    end
  end
  
  
end
