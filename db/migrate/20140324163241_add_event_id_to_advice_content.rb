class AddEventIdToAdviceContent < ActiveRecord::Migration
  def change
    add_column :advice_contents, :event_id, :integer
  end
end
