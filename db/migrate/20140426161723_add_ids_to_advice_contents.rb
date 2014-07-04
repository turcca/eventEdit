class AddIdsToAdviceContents < ActiveRecord::Migration
  def change
    add_column :advice_contents, :engineer_id, :int
    add_column :advice_contents, :quartermaster_id, :int
    add_column :advice_contents, :security_id, :int
    add_column :advice_contents, :priest_id, :int
    add_column :advice_contents, :psycher_id, :int
  end
end
