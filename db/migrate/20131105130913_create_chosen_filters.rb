class CreateChosenFilters < ActiveRecord::Migration
  def change
    create_table :chosen_filters do |t|
      t.integer :event_id
      t.integer :filter_id

      t.timestamps
    end
  end
end
