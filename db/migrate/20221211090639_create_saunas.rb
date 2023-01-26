class CreateSaunas < ActiveRecord::Migration[6.1]
  def change
    create_table :saunas do |t|
      t.string :name
      t.integer :user_id
      t.string :image_id
      t.integer :water_temperature
      t.time :open_time
      t.time :close_time
      t.integer :sauna_temperature
      t.integer :sauna_capacity
      t.integer :water_capacity
      t.text :sauna_body
      t.text :water_body
      t.boolean :louly_aufgoose
      t.text :louly_body
      t.boolean :rest_space
      t.text :rest_body
      t.string :address
      t.string :access
      t.integer :tel
      t.string :price

      t.timestamps
    end
  end
end
