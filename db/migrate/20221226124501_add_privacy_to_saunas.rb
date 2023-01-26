class AddPrivacyToSaunas < ActiveRecord::Migration[6.1]
  def change
    add_column :saunas, :privacy, :string
  end
end
