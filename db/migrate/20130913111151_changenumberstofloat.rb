class Changenumberstofloat < ActiveRecord::Migration
  def self.up
    change_column :probabilities, :value1, :float
    change_column :probabilities, :value2, :float
  end
  
  def self.down
    change_column :probabilities, :value1, :string
    change_column :probabilities, :value2, :string
  end
end
