class SetDefaultValues < ActiveRecord::Migration
  def change
    change_column :events, :frequency, :string, default: "Default"
    change_column :events, :situation, :string, default: "Default"
    change_column :events, :ambient, :string, default: "DefaultBridge"
  end
end
