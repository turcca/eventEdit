class CreateAdviceContents < ActiveRecord::Migration
  def change
    create_table :advice_contents do |t|
      t.string :type
      t.string :condition
      t.integer :tool_id
      t.string :equality
      t.string :value
      t.string :and
      t.string :text

      t.timestamps
    end
  end
end
