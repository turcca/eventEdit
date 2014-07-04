class ChangePToFloatInProbabilities < ActiveRecord::Migration
  def change
    change_column :probabilities, :p, :float, default: 0
  end
end
