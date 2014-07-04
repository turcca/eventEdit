class AddRangevalueToProbabilities < ActiveRecord::Migration
  def change
    add_column :probabilities, :rangevalue, :string
  end
end
