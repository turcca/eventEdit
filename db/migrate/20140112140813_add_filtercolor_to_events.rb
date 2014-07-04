class AddFiltercolorToEvents < ActiveRecord::Migration
  def change
    add_column :events, :filtercolor, :string
  end
end
