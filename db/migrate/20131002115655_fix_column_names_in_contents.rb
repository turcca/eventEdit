class FixColumnNamesInContents < ActiveRecord::Migration
  def change
    rename_column :contents, :tool1, :tool1_id
    rename_column :contents, :tool2, :tool2_id
    rename_column :contents, :skill1, :skill1_id
    rename_column :contents, :skill2, :skill2_id
  end
end
