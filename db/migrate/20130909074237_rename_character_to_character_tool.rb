class RenameCharacterToCharacterTool < ActiveRecord::Migration
  def change
    rename_column :events, :character, :character_tool
  end
end
