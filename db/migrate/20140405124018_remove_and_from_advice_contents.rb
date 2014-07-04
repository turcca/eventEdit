class RemoveAndFromAdviceContents < ActiveRecord::Migration
  def change
    remove_column :advice_contents, :and, :string
  end
end
