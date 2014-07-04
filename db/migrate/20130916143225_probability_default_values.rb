class ProbabilityDefaultValues < ActiveRecord::Migration
  def change
    change_column :probabilities, :value1, :float, default: 0
    change_column :probabilities, :value2, :float, default: 0
  end
end
