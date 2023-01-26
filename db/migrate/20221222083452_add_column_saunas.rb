class AddColumnSaunas < ActiveRecord::Migration[6.1]
  def change
    add_column :saunas, :http, :string
  end
end
