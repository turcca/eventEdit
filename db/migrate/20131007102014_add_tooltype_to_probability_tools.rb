class AddTooltypeToProbabilityTools < ActiveRecord::Migration
  def change
    add_column :probability_tools, :tooltype, :string
  end
end
