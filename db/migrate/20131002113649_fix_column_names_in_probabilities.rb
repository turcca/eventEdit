class FixColumnNamesInProbabilities < ActiveRecord::Migration
  def change
    rename_column :probabilities, :tool1, :tool1_id
    rename_column :probabilities, :tool2, :tool2_id
  end
end
