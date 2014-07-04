class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.integer :tool_id
      t.integer :parameter_type_id

      t.timestamps
    end
  end
end
