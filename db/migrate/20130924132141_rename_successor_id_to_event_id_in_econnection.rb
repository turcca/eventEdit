class RenameSuccessorIdToEventIdInEconnection < ActiveRecord::Migration
  def change
    rename_column :econnections, :successor_id, :event_id
  end
end
