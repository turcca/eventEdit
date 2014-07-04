class PreToolAssociation < ActiveRecord::Base
  
  belongs_to :tool
  belongs_to :pre_tool, :class_name => 'Tool'
  
  attr_accessor :enabled
  
end
