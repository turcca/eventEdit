class AddAncestryToAdviceContent < ActiveRecord::Migration
  def change
    add_column :advice_contents, :ancestry, :string
  end
end
