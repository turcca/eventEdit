class AddCompleteToChosenTools < ActiveRecord::Migration
  def change
    add_column :chosen_tools, :complete, :boolean
  end
end
