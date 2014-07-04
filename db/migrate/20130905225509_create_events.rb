class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :comment
      t.string :character

      t.timestamps
    end
  end
end
