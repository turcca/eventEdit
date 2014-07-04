class ChangePToStringInProbabilities < ActiveRecord::Migration
  def change
    change_column :probabilities, :p, :string, default: '0'
  end
end
