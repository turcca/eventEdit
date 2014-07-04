class AddSystemToParameterTypes < ActiveRecord::Migration
  def change
    add_column :parameter_types, :system, :boolean
  end
end
