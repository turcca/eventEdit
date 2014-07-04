class AddAdviceToTools < ActiveRecord::Migration
  def change
    add_column :tools, :advice, :boolean
  end
end
