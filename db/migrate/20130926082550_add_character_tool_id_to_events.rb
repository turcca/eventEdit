class AddCharacterToolIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :character_tool_id, :integer
  end
end
