class AddSystemToTools < ActiveRecord::Migration
  def change
    add_column :tools, :system, :boolean
  end
end
