class CreateProbabilities < ActiveRecord::Migration
  def change
    create_table :probabilities do |t|
      t.string :condition
      t.string :tool1
      t.string :equality1
      t.string :value1
      t.string :andor
      t.string :tool2
      t.string :equality2
      t.string :value2
      t.string :p

      t.timestamps
    end
  end
end
