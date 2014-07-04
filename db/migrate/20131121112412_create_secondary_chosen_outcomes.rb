class CreateSecondaryChosenOutcomes < ActiveRecord::Migration
  def change
    create_table :secondary_chosen_outcomes do |t|
      t.integer :secondary_prereq_id
      t.integer :content_outcome_id

      t.timestamps
    end
  end
end
