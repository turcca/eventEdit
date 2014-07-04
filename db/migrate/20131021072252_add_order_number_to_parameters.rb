class AddOrderNumberToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :order_number, :integer
  end
end
