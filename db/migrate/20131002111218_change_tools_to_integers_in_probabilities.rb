class ChangeToolsToIntegersInProbabilities < ActiveRecord::Migration
  def change
    change_column :probabilities, :tool1, :integer
    change_column :probabilities, :tool2, :integer
  end
end
