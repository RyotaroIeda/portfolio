class ChangeAccessStringToText < ActiveRecord::Migration[6.1]
  def change
    change_column :saunas, :access, :text
  end
end
