class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :tooltype
      t.boolean :character
      t.boolean :probability
      t.boolean :content_condition
      t.boolean :content_effect
      t.boolean :pre_tool

      t.timestamps
    end
  end
end
