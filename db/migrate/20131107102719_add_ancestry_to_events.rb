class AddAncestryToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ancestry, :string
    add_index :events, :ancestry
  end
end
