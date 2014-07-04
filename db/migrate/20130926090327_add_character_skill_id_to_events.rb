class AddCharacterSkillIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :character_skill_id, :integer
  end
end
