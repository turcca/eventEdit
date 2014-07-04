class AddTriggerToolIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :trigger_tool_id, :integer
  end
end
