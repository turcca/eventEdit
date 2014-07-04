class AddTooltipToParameterValues < ActiveRecord::Migration
  def change
    add_column :parameter_values, :tooltip, :string
  end
end
