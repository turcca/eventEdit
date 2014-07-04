class AddCustomValueToChosenParameters < ActiveRecord::Migration
  def change
    add_column :chosen_parameters, :custom_value, :string
  end
end
