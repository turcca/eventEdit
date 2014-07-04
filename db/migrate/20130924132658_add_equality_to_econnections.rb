class AddEqualityToEconnections < ActiveRecord::Migration
  def change
    add_column :econnections, :equality, :string
  end
end
