class CreateParameterValues < ActiveRecord::Migration
  def change
    create_table :parameter_values do |t|
      t.integer :parameter_type_id
      t.string :name

      t.timestamps
    end
  end
end
