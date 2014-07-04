class AddTooltipToTools < ActiveRecord::Migration
  def change
    add_column :tools, :tooltip, :string
  end
end
