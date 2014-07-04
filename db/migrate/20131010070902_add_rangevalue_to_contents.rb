class AddRangevalueToContents < ActiveRecord::Migration
  def change
    add_column :contents, :rangevalue, :string
  end
end
