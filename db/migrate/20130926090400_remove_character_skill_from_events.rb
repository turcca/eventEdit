class RemoveCharacterSkillFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :character_skill
  end
end
