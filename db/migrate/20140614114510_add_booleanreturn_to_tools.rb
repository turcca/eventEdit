class AddBooleanreturnToTools < ActiveRecord::Migration
  def change
    add_column :tools, :booleanreturn, :boolean
  end
end
