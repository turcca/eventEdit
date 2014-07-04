class AddParameterIdToChosenParameters < ActiveRecord::Migration
  def change
    add_column :chosen_parameters, :parameter_id, :integer
  end
end
