class RemoveCharacterSkillIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :character_skill_id
  end
end
