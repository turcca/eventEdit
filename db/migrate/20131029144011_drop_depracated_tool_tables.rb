class DropDepracatedToolTables < ActiveRecord::Migration
  def change
    drop_table :character_tools
    drop_table :character_skills
    drop_table :probability_tools
    drop_table :content_tools
    drop_table :content_effect_tools
  end
end
