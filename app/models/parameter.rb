class Parameter < ActiveRecord::Base
  default_scope -> { order(:tool_id, :order_number) }
  
  validates_uniqueness_of :order_number, :scope => [:tool_id]
  
  belongs_to :parameter_type
  belongs_to :tool
  has_many :chosen_parameters, :dependent => :destroy
  
  before_destroy :handle_order_numbers
  
  private
  
  def handle_order_numbers
    good_parameters = []
    self.tool.parameters.each do |tool_parameter|
      if tool_parameter.parameter_type != self.parameter_type
        good_parameters << tool_parameter
      end
    end
    good_parameters.each_with_index do |good_parameter, index|
      if good_parameter.order_number != index + 1
        good_parameter.order_number = index + 1
        good_parameter.save(:validate => false)
      end
    end
    
    true
  end
  
end
