class CreateSecondaryPrereqs < ActiveRecord::Migration
  def change
    create_table :secondary_prereqs do |t|
      t.integer :event_id
      t.integer :prereq_id

      t.timestamps
    end
  end
end
