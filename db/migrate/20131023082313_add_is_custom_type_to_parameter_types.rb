class AddIsCustomTypeToParameterTypes < ActiveRecord::Migration
  def change
    add_column :parameter_types, :is_custom_type, :boolean
  end
end
