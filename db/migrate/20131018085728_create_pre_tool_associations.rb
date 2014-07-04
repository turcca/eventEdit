class CreatePreToolAssociations < ActiveRecord::Migration
  def change
    create_table :pre_tool_associations do |t|
      t.integer :pre_tool_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
