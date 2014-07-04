class AddLocationToolIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location_tool_id, :integer
  end
end
