class AddTriggerToTools < ActiveRecord::Migration
  def change
    add_column :tools, :trigger, :boolean
  end
end
