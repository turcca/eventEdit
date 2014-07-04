class CreateChosenOutcomes < ActiveRecord::Migration
  def change
    create_table :chosen_outcomes do |t|
      t.integer :event_id
      t.integer :content_outcome_id

      t.timestamps
    end
  end
end
