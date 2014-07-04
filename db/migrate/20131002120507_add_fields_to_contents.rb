class AddFieldsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :value1, :string
    add_column :contents, :value2, :string
  end
end
