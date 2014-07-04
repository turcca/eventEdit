class ParameterType < ActiveRecord::Base
  default_scope -> { order('name') }
  
  validates :name, :presence => true, :uniqueness => true
  
  has_many :parameter_values, :dependent => :destroy
  has_many :parameters, :inverse_of => :parameter_type, :dependent => :destroy
  
  accepts_nested_attributes_for :parameter_values, :allow_destroy => true
  
  before_save :mark_values_for_removal_and_set_is_custom_type
  
  private
  
  def mark_values_for_removal_and_set_is_custom_type
    custom = false
    parameter_values.each do |value|
      if value.name.blank?
        value.mark_for_destruction
      else
        custom = true
      end
    end
    self.is_custom_type = custom
    true
  end
  
end
