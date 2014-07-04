class AddLocationToTools < ActiveRecord::Migration
  def change
    add_column :tools, :location, :boolean
  end
end
