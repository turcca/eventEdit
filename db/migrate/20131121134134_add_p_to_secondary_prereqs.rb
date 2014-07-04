class AddPToSecondaryPrereqs < ActiveRecord::Migration
  def change
    add_column :secondary_prereqs, :p, :string
  end
end
