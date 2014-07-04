class CreateChosenTools < ActiveRecord::Migration
  def change
    create_table :chosen_tools do |t|
      t.integer :tool_id
      t.integer :pre_tool_id

      t.timestamps
    end
  end
end
