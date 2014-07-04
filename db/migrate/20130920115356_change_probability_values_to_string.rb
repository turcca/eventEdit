class ChangeProbabilityValuesToString < ActiveRecord::Migration
  def change
    change_column :probabilities, :value1, :string, default: '0'
    change_column :probabilities, :value2, :string, default: '0'
  end
end
