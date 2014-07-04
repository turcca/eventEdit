class AddCharacterSkillToEvents < ActiveRecord::Migration
  def change
    add_column :events, :character_skill, :string
  end
end
