class CreateChosenParameters < ActiveRecord::Migration
  def change
    create_table :chosen_parameters do |t|
      t.integer :chosen_tool_id
      t.integer :parameter_value_id

      t.timestamps
    end
  end
end
