class AddColorToFilters < ActiveRecord::Migration
  def change
    add_column :filters, :color, :string
  end
end
