class AddEventIdToProbabilities < ActiveRecord::Migration
  def change
    add_column :probabilities, :event_id, :integer
  end
end
