class ChangeColumnOnSaunaOnTel < ActiveRecord::Migration[6.1]
  def change
    change_column :saunas, :tel, :string
  end
end
