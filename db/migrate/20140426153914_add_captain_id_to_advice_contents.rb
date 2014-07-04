class AddCaptainIdToAdviceContents < ActiveRecord::Migration
  def change
    add_column :advice_contents, :captain_id, :int
    add_column :advice_contents, :navigator_id, :int
    remove_column :advice_contents, :event_id, :int
  end
end
