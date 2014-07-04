class RemoveCharacterToolFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :character_tool
  end
end
