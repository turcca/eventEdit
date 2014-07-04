class ChangeCommentToTextInEvents < ActiveRecord::Migration
  def change
    change_column :events, :comment, :text
  end
end
