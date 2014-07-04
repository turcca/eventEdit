class RenamePreToolToIsPreToolInTools < ActiveRecord::Migration
  def change
    rename_column :tools, :pre_tool, :is_pre_tool
  end
end
