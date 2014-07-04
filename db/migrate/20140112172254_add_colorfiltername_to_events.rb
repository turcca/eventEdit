class AddColorfilternameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :colorfiltername, :string
  end
end
