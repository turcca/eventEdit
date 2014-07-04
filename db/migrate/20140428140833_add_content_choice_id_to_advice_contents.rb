class AddContentChoiceIdToAdviceContents < ActiveRecord::Migration
  def change
    add_column :advice_contents, :content_choice_id, :int
  end
end
