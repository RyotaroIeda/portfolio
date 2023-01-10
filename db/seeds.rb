# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do |n|
  Sauna.create!(
		user_id: 5,
    name: "テストサウナ#{n + 1}",
		water_temperature: 10,
		water_capacity: 6,
		water_body: "すごい",
		sauna_capacity: 30,
		sauna_body: "熱い",
		sauna_temperature: 100,
		tel: "094-4444-5555",
		privacy: 1
  )
end
