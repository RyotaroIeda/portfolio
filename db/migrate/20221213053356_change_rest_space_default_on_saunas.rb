class ChangeRestSpaceDefaultOnSaunas < ActiveRecord::Migration[6.1]
  def change
    change_column :saunas, :rest_space, :boolean, default: false, null: false
    change_column :saunas, :louly_aufgoose, :boolean, default: false, null: false
  end
end
