class AddTooltypeToContentTools < ActiveRecord::Migration
  def change
    add_column :content_tools, :tooltype, :string
  end
end
