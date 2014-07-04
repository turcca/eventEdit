class CreateParameterTypes < ActiveRecord::Migration
  def change
    create_table :parameter_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
