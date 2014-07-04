class ParameterValue < ActiveRecord::Base
  
  validates_uniqueness_of :name, :scope => [:parameter_type_id]
  
  belongs_to :parameter_type
  has_many :chosen_parameters, :dependent => :destroy
  
end
