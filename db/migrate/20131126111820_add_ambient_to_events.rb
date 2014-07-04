class AddAmbientToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ambient, :string
  end
end
