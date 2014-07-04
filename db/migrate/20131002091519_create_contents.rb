class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :ancestry
      t.string :type
      t.text :text
      t.string :condition
      t.integer :tool1
      t.integer :skill1
      t.string :equality1
      t.string :andor
      t.integer :tool2
      t.integer :skill2
      t.string :equality2
      t.integer :event_id

      t.timestamps
    end
    
    add_index :contents, :ancestry
  end
end
